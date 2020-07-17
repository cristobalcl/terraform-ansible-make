resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.tmpl",
    {
      server_server_ip = digitalocean_droplet.server_droplet.ipv4_address
    }
  )
  filename = "inventory"
}

resource "local_file" "bash_config" {
  content = templatefile("templates/config.sh.tmpl",
    {
      pvt_key = var.pvt_key
    }
  )
  filename = "config.sh"
}
