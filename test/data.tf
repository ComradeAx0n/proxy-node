terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.24.0"
    }
  }
}

provider "linode" {
  token = "9b6fbbf0bb66af678bf9577c7a861e00965a3fd9db7e855e6baba0c7da93fe0d"
}

