variable "web_nic_name" {}
variable "app_nic_name" {}
variable "db_nic_name" {}
variable "web_vm_name" {}
variable "app_vm_name" {}
variable "db_vm_name" {}
variable "vm_size" {}
variable "web_hostname" {}
variable "app_hostname" {}
variable "db_hostname" {}
variable "username" {}
variable "password" {}

variable "subnets" {
  type = map(object({
    name = string
    address_prefix = list(string)
  }))
  default = {
    web_subnet = {
      name = "web_subnet-eastus2"
      address_prefix = ["10.0.1.0/24"]
    },
    app_subnet = {
      name = "app_subnet-eastus2"
      address_prefix = ["10.0.2.0/24"]
    },
    db_subnet = {
      name = "db_subnet-eastus2"
      address_prefix = ["10.0.3.0/24"]
    }
  }
}