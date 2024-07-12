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

variable "subnets" {
  type = map(object({
    az                      = string
    cidr_block              = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
}

variable "public_route_table" {
  type = object({
    tags = map(string)
  })
}

