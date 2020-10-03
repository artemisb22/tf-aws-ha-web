module "webservers" {
    source     = "../../modules/webservers"

	### Main Variables ###
	key_name	= var.key_name
	instance_type	= var.instance_type
	root_volume_size	= var.root_volume_size
	ami_id	= var.ami_id
	vpc_id	= var.vpc_id
	subnet_ids	= var.subnet_ids
    elb_subnet_id = var.elb_subnet_id

	### Security Access Variables ###

	ssh_access_cidr_blocks     = ["0.0.0.0/0"]
    ssh_access_security_groups = []

	web_access_cidr_blocks	= ["0.0.0.0.0/0"]
	web_access_security_groups	= []

	web_nodes_count = var.web_nodes_count

	haproxy_access_cidr_blocks	= ["0.0.0.0.0/0"]
	haproxy_access_security_groups	= []

	haproxy_nodes_count = var.haproxy_nodes_count
}
