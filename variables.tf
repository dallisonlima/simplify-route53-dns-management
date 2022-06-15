variable "region" {
  type        = string
  description = "Region default"
  default     = "us-east-1"
}

variable "cidr_vpc" {
  type        = string
  description = "Module VPC cidr"
}