resource "linode_instance" "terraform-web" {
  image = "linode/ubuntu20.04"
  label = "Terraform-Web-Example"
  group = "Terraform"
  region = "us-east"
  type = "g6-nanode-1"
  authorized_keys = [ file(var.pubkey) ]

  provisioner "local-exec" {
    command = "ansible-galaxy install -r ./ansible/requirements.yml &&ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.prvkey} ./ansible/main.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}