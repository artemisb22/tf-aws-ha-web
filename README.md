#  AWS EC2 and ELB Terraform module
AWS Terraform module which creates two web servers and two HAproxy in HA mode. Both the web servers and haproxy will be behind a aws elb.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.7 |
| aws | >= 2.68 |

These types of resources are supported:

* [EC2 instance]
* [ELB]
* [Elastic IP]

## Usage

To run this example you need to cd into environment/web directory and execute:

```bash
$ export AWS_ACCESS_KEY_ID="my-accesskey"
$ export AWS_SECRET_ACCESS_KEY="my-secretkey"
$ terraform init 
$ terraform plan 
$ terraform apply
```
