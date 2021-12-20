variable "token" {
  type = string
  default = "9b6fbbf0bb66af678bf9577c7a861e00965a3fd9db7e855e6baba0c7da93fe0d"
  sensitive = true
}
variable "pubkey" {
  type = string
  default = "./keys/pubkey"
}
variable "prvkey" {
  type = string
  default = "./keys/prvkey"
}
variable "nodes_count" {
  type = number
  default = 1
}
variable "region" {
  type = string
  default = "us-east"
}
variable "type" {
  type = string
  default = "g6-nanode-1"
}
variable "ipv6_subnet_full" {
  type = string
  default = "2600:3c03:e000:01ec::/64"
}