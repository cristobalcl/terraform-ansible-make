.PHONY: help plan apply destroy all

SHELL := /bin/bash

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

init:           ## Init Terraform
	terraform init

plan:           ## Calculate infraestructure changes
	terraform plan

apply:          ## Apply changes to infraestructure
	terraform apply

inventory config.sh:
	terraform apply

provision:      ## Apply changes to infraestructure
provision: inventory config.sh
	. config.sh
	echo $$PVT_KEY
	ssh-add $$PVT_KEY
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory playbooks/server_provision.yaml

destroy:        ## Destroy infraestructure
	terraform destroy

all: help
