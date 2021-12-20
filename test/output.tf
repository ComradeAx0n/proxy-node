output "ip_node" {
  description = "IP address of node"
  value = "${linode_instance.web-node.*.ip_address}"
}