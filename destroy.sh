#!/bin/bash
red=`tput setaf 1`
blue=`tput setaf 4`
reset=`tput sgr0`
bold=$(tput bold)
echo -e
echo -e "${bold}${red}Starting Terraform Destroy with Auto-Approve in 5 seconds${reset}"
terraform destroy -var-file aws_variables.tfvars --auto-approve
echo -e
echo -e "${blue}${bold}Thank you${reset}"
echo -e