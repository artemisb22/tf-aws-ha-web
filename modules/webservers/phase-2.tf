resource "aws_instance" "web_nodes" {
  count                       = var.web_nodes_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  user_data                   = data.template_file.web.rendered
  subnet_id                   = data.aws_subnet.default.id
  key_name                    = var.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  tags = {
    Name        = "web-${count.index + 1}"
    Provisioner = "terraform"
    Role        = "web"
    Service     = "blabla.everc.io"
  }

}

data "template_file" "web" {
  template = file( "${ path.module }/user-data/ph-2-web.sh" )
}

resource "aws_eip" "web_eip" {
  instance = element(aws_instance.web_nodes.*.id,count.index)
  count = var.web_nodes_count
  vpc = true
}

resource "aws_instance" "haproxy_nodes" {
  count                       = var.haproxy_nodes_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  user_data                   = data.template_file.haproxy.rendered
  subnet_id                   = data.aws_subnet.default.id
  key_name                    = var.key_name
  depends_on = [aws_instance.web_nodes]
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  tags = {
    Name        = "haproxy-${count.index + 1}"
    Provisioner = "terraform"
    Role        = "haproxy"
  }
}

data "template_file" "haproxy" {
  template = file( "${ path.module }/user-data/haproxy.sh" )
  vars = {
    NODE1_IP = element(flatten(aws_instance.web_nodes.*.public_ip), 0)
    NODE2_IP = element(flatten(aws_instance.web_nodes.*.public_ip), 1)
  }
}
