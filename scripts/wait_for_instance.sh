#!/bin/bash
# From: https://github.com/hashicorp/terraform/issues/2811#issuecomment-281053827

while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
  echo -e "\033[1;36mWaiting for cloud-init..."
  sleep 1
done
