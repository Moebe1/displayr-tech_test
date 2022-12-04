#!/bin/bash
green=`tput setaf 2`
reset=`tput sgr0`
bold=$(tput bold)
echo -e
echo -e "${bold}${green}Starting terraform apply with Auto Approve, in 5 seconds${reset}"
echo -e
terraform apply -var-file aws_variables.tfvars --auto-approve &&
echo -e
echo -e "${green}Please wait, starting readiness check in 5 seconds${reset}"
echo -e
sleep 5 
./ready_check.sh
