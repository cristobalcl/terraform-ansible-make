resource "digitalocean_ssh_key" "default" {
  name = "Server Key"
  public_key = file(var.pub_key)
}

resource "digitalocean_droplet" "server_droplet" {
  name = "server-server"
  image = "ubuntu-20-04-x64"
  region = "lon1"
  size = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  provisioner "remote-exec" {
    connection {
      host = self.ipv4_address
      user = "root"
      type = "ssh"
      private_key = file(var.pvt_key)
      timeout = "2m"
    }
    script = "scripts/wait_for_instance.sh"
  }
  provisioner "local-exec" {
    command = "ssh-add ${var.pvt_key}; PUB_KEY=${var.pub_key} ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.ipv4_address},' -u root playbooks/server_init.yaml"
    on_failure = continue
  }
}
