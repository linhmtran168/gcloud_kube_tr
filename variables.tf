variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "general_machine_type" {
  type = string
}
variable "min_node_count" {
  type = number
}
variable "max_node_count" {
  type = number
}
variable "is_preemptible" {
  type = bool
}