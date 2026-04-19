variable "pip" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    pip_location        = string
  }))
}