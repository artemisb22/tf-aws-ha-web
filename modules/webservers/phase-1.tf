resource "aws_instance" "ph-1-web_nodes" {
  count                       = var.web_nodes_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  user_data                   = data.template_file.ph1-web.rendered
  key_name                    = var.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  tags = {
    Name        = "ph-1-web-${count.index + 1}"
    Provisioner = "terraform"
    Role        = "web"
    ServiceName = var.ph-1-service_name
  }

}

data "template_file" "ph1-web" {
  template = file( "${ path.module }/user-data/ph-1-web.sh" )
}
