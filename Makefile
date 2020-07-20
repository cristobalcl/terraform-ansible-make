.PHONY: help plan apply destroy all

SHELL := /bin/bash

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

init:           ## Init Terraform
	terraform init

plan:           ## Calculate infrastructure
	terraform plan

apply:          ## Apply changes to infrastructure
	terraform apply

inventory config.sh:
	terraform apply

provision:      ## Apply changes to infrastructure
provision: inventory config.sh
	. config.sh
	ssh-add $$PVT_KEY
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory playbooks/server_provision.yaml

destroy:        ## Destroy infrastructure
	terraform destroy

all: help
