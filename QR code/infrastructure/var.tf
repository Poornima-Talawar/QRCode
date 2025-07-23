variable "environment" {
  type = string
  description = "Environment values"
  default = "Dev"
}

variable "available_zones" {
    type = list(string)
    description = "Available values"
    default = [ "East US","West US","Europe" ]
  
}