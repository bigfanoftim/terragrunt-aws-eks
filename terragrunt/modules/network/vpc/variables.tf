variable "vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
}

variable "internet_gateway" {
  type = object({
    tags = map(string)
  })
  default = {
    tags = {}
  }
}

variable "public_subnets" {
  type = map(object({
    az         = string
    cidr_block = string
    tags       = map(string)
  }))
}

variable "public_route_table" {
  type = object({
    tags = map(string)
  })
}

