variable "resource_group" {
    type = map(object({
      rg_name = string
      rg_location = string
    }))
}


