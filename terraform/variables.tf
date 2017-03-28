variable "tenant_name" {}
variable "user_name" {}
variable "password" {}
variable "environment" {}
variable "node_name" {}
variable "salt_master" {}
variable "auth_url" {
 default = "https://openstack.tacc.chameleoncloud.org:5000/v2.0"
}
