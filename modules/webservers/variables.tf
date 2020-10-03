variable "vpc_id" {}
variable "ami_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "root_volume_size" {}

variable "ssh_access_security_groups" {
}

variable "ssh_access_cidr_blocks" {
}

variable "web_access_security_groups" {
}

variable "web_access_cidr_blocks" {
}

variable "subnet_ids" {
}

variable "web_nodes_count" {
}

variable "elb_subnet_id" {
  type = list(string)
}

variable "haproxy_access_security_groups" {
}

variable "haproxy_access_cidr_blocks" {
}

variable "haproxy_nodes_count" {
}