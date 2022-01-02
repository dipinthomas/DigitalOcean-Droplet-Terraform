output "droplet_floating_addr" {
  value = digitalocean_floating_ip.cow.ip_address
}

output "droplet_name" {
  value = digitalocean_droplet.cow.name
}