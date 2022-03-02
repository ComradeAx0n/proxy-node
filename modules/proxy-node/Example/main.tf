module "web-proxy" {
  source = "../linode/modules/proxy-node"

  token = "3ac01da48b7a2ed5bb9c3e87c9f6ca4b6b7fcecfcb773684c8df6932977e2ac9"
  label = "web-node"
  region = "us-east"
}