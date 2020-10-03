variable "aws_region" {
    default = "eu-west-3"
}

variable "key_name" {
  default = "lab-key"
}

variable "instance_type" {
    default = "t2.small"
}

variable "root_volume_size" {
    default = "16"
}

variable "ami_id" {
    default = "ami-057cc319e24b70b63"
}

variable "elb_subnet_id" {
  default = ["subnet-eb5e7d90", "subnet-9f384cd2"]
}

### Security Access Variables

variable "ssh_access_cidr_blocks" {
    default = []
}

variable "ssh_access_security_groups" {
    default = []
}

variable "web_access_cidr_blocks" {
    default = []
}

variable "web_access_security_groups" {
    default = []
}

### Variables for user-data ###
variable "web_nodes_count" {
  default = "2"
}

variable "haproxy_access_cidr_blocks" {
  default = []
}

variable "haproxy_access_security_groups" {
  default = []
}

### Variables for user-data ###
variable "haproxy_nodes_count" {
  default = "2"
}