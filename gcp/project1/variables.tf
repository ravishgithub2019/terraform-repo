variable "environment" {
  type    = string
  default = "dev"
}

variable "machine_types" {
  type    = map
  default = {
    dev  = "e2-micro"
    test = "e2-small"
    prod = "e2-medium"
  }
}

