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
variable "ipv6_subnet_full" {
  type = string
  default = "2600:3c03:e000:01ec::/64"
}