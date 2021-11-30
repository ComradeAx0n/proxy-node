resource "linode_instance" "web-node" {
  count = var.nodes_count
  tags = ["web", "node"]

  image = "linode/ubuntu20.04"
  label = "web-node-${count.index + 1}"
  group = "web"
  region = "us-east"
  type = "g6-nanode-1"
  authorized_keys = [ file(var.pubkey) ]
  private_ip = true

  provisioner "local-exec" {
    command = "ansible-galaxy install -r ./ansible/requirements.yml && sleep 60 && ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.prvkey} -e 'proxy_port=${var.proxy_port}' -e 'new_hostname=${self.label}' -e 'ipv6_subnet_full=${var.ipv6_subnet_full}' ./ansible/main.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

resource "linode_instance_ip" "web-node-ipv6" {
  count = var.nodes_count
  linode_id = linode_instance.web-node[count.index].id
}