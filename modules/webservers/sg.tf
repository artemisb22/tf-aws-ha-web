### Security Group ###

data "aws_vpc" "default" {
  default = true
}

data "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
    ingress {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = var.ssh_access_cidr_blocks
      security_groups = var.ssh_access_security_groups
    }
    ingress {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = var.web_access_security_groups
    }
    ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      self      = true
    }
    lifecycle {
      create_before_destroy = true
    }
  }
