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
    command = "ansible-galaxy install -r ./ansible/requirements.yml && sleep 30 && ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.prvkey} -e 'proxy_port=${var.proxy_port}' ./ansible/main.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

resource "linode_nodebalancer" "web-nbl" {
  label = "web-nbl"
  region = "us-east"
  client_conn_throttle = 20
  tags = ["web", "nbl"] 
}

resource "linode_nodebalancer_config" "web-nbl-cfg" {
  nodebalancer_id = linode_nodebalancer.web-nbl.id
  port = var.proxy_port
  protocol = "http"
  check = "connection"
  check_interval = 5
  check_attempts = 2
  check_timeout = 3
  stickiness = "table"
  algorithm = "leastconn"
}

resource "linode_nodebalancer_node" "web-nbl-node" {
  count = var.nodes_count
  nodebalancer_id = linode_nodebalancer.web-nbl.id
  config_id = linode_nodebalancer_config.web-nbl-cfg.id
  address = "${element(linode_instance.web-node.*.private_ip_address, count.index)}:${var.proxy_port}"
  label = "web-nbl-node"
  weight = 50
}
