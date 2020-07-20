Terraform + Ansible
===================

Companion project for the article series: [Terraform + Ansible: tips & tricks](https://medium.com/@cristobalcl/terraform-ansible-tips-tricks-3873a536eecf).

Setup
-----

Create a [DigitalOcean](https://m.do.co/c/36e391fa75d0) account (referral link) if you don't have one. Go to the [API section](https://cloud.digitalocean.com/account/api/tokens) of your DigitalOcean account, and click in the *"Generate New Token"* button. Save the token to use later.

Create a new SSH key:

```
ssh-keygen -t rsa -b 4096 -C "your@email.here" -f ~/.ssh/server_rsa -q -N ""
```

Create a config file:

```
cp config.auto.tfvars.tmpl config.auto.tfvars
```

Edit the new `config.auto.tfvars` file, update the path to your new keys and put your generated token.

Use
---

Show help:

```
make
```

Deploy everything:

```
make provision
```

Once all is deployed you can do note down the droplet IP (you can see the IP in the inventory file that will be created) and do:

```
curl http://<DROPLET_IP>
```

You should get the Nginx default page.

If you run `make provision` again, only the provision Ansible playbook should run. If you make changes in the infraestructure (Terraform files) you can apply those changes with:

```
make apply
```

Don't forget to destroy everything after doing your tests:

```
make destroy
```
