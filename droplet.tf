resource "digitalocean_floating_ip" "cow" {
  region = var.droplet_region
}

resource "digitalocean_droplet" "cow" {
  image             = var.dorplet_image
  name              = var.droplet_name
  region            = var.droplet_region
  size              = var.droplet_size
  graceful_shutdown = false
  ssh_keys          = [digitalocean_ssh_key.default.fingerprint]  # replace it if you existing SSH is being used [data.digitalocean_ssh_key.default.id]

  connection {
    host        = self.ipv4_address
    user        = var.droplet_user
    type        = "ssh"
    private_key = file(var.pvt_key_location)
    timeout     = var.droplet_connection_timeout
  }

  provisioner "remote-exec" {
    inline = [
      #Updat OS
      "apt update",
      #Install Docker
      "apt install docker.io -y",
      #Install Docker-Compose
      "sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
    ]
  }
}

resource "digitalocean_floating_ip_assignment" "cow" {
  ip_address = digitalocean_floating_ip.cow.ip_address
  droplet_id = digitalocean_droplet.cow.id
}
