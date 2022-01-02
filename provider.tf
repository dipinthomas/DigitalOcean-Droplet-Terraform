terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.16.0"
    }
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.do_token
}

########
# To use a key which is already present in DigitalOcean
#
# replace <existing_SSH_key> with key name. 
# 
# Key name can be found by following below steps
# login screen --> Settings --> Security --> SSH Keys
########

# data "digitalocean_ssh_key" "default" {
#   name = "<existing_SSH_key>"
# }

#####
# This resource will register new SSH key on DigitalOcean
#####
resource "digitalocean_ssh_key" "default" {
  name       = "digit"
  public_key = file(var.pub_key_location)
}