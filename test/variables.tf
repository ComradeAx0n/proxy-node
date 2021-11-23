variable "pubkey" {
  type = string
  default = "./keys/pubkey"
}
variable "prvkey" {
  type = string
  default = "./keys/prvkey"
}
variable "proxy_port" {
  type = number
  default = 3140
}
variable "nodes_count" {
  type = number
  default = 2
}