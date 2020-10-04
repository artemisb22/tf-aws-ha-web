variable "access_key" {
  default = "AKIAZMDHVEYKX4XNOS5R"
}

variable "secret_key" {
  default = "PNTjPWApUhUnylg8A+rpQ0KFfF8kK2QgIRG2WXJf"
}

variable "aws_region" {
    default = "eu-west-3"
}

variable "key_name" {
  default = "lab-key"
}

variable "instance_type" {
    default = "t2.small"
}

variable "ph-1-service_name" {
  default = "blabla.everc.com"
}

variable "ph-2-service_name" {
  default = "blabla.everc.io"
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