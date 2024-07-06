#!/bin/bash

check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        echo " "
        echo "---------------------------------------------------------------------"
        echo ">>> Running as root."
        echo "---------------------------------------------------------------------"
    elif pgrep -s 0 '^sudo$' > /dev/null ; then
        echo " "
        echo "---------------------------------------------------------------------"
        echo ">>> Running with sudo."
        echo "---------------------------------------------------------------------"
    else
        echo " "
        echo "---------------------------------------------------------------------"
        echo ">>> ERROR: This script must be run as root or with sudo. Exiting..."
        echo "---------------------------------------------------------------------"
        exit 1
    fi
}

run_terraform() {
    echo "---------------------------------------------------------------------"
    read -p ">>> Run Terraform (r), destroy (d) or exit (e)?: " choice
    echo "---------------------------------------------------------------------"
    if [ "$choice" == "r" ]; then
        terraform init
        terraform plan
        terraform validate
        terraform apply
        #terraform output
    elif [ "$choice" == "d" ]; then
        terraform destroy
    else
        exit 1
    fi
}

echo "---------------------------------------------------------------------"
echo " "
echo " >>> CF-DevOps"
echo " >>> Making the infrastructure ready"
echo " "
echo "---------------------------------------------------------------------"
sleep 2

# Cleanup execution enable
chmod +x $PWD/local/local_setup.sh
chmod +x $PWD/local/gcloud_cli.sh
chmod +x $PWD/local/terraform.sh

# Check if the script is running as root
check_root

# Prepare the local environment
$PWD/local/local_setup.sh

# Run Terraform
run_terraform

echo " "
echo "-------------------------------------------------"
cat $PWD/ansible/inventory
echo "-------------------------------------------------"
echo " > All task completed!"
echo "-------------------------------------------------"

sleep 2
