#!/bin/bash

echo "-------------------------------------------------"
echo " > Installing GCP CLI"
echo "-------------------------------------------------"
echo " "
$PWD/gcloud_cli.sh

echo "-------------------------------------------------"
echo " > Installing terraform"
echo "-------------------------------------------------"
echo " "
$PWD/terraform.sh

echo "-------------------------------------------------"
echo " > Insert GCP Auth"
echo "-------------------------------------------------"
echo " "
sudo nano ../gcloud.json

echo "-------------------------------------------------"
echo " > Insert Postgres Password"
echo "-------------------------------------------------"
echo " "
read -p ">>> Insert Postgres password: " pgpass
sudo sed -i "s/$pgpass/postgres_this_password_will_change/g" ../ansible/roles/main/tasks/main.yml

echo "-------------------------------------------------"
echo " > Insert Grafana Password"
echo "-------------------------------------------------"
echo " "
read -p ">>> Insert Grafana password: " grafanapass
sudo sed -i "s/$grafanapass/grafana_this_password_will_change/g" ../ansible/roles/k8smaster/tasks/main.yml

echo " "
echo " "
echo "-------------------------------------------------"
echo " > Script completed!"
echo "-------------------------------------------------"
echo " > GCloud CLI Version:"
aws --version
echo " > Terraform Version:"
terraform --version
echo "-------------------------------------------------"
echo " "
echo " "
sleep 4
