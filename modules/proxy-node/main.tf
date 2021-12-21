resource "linode_instance" "web-node" {
  count = var.nodes_count
  tags = ["web", "node"]

  image = "linode/ubuntu20.04"
  label = "web-node-${count.index + 1}"
  group = "web"
  region = var.region
  type = var.type
  authorized_keys = [ file("${path.module}/keys/pubkey") ]
}
