variable "cidr" {
  type        = string
  description = "VPC Cidr"
}

variable "all_tags" {
  type        = map(any)
  description = "Default VPC tags"
  default = {
    "VPC" = "Terraform module VPC"
  }
}