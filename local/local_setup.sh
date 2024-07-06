#!/bin/bash

echo "-------------------------------------------------"
echo " > Installing GCP CLI"
echo "-------------------------------------------------"
echo " "
$PWD/local/gcloud_cli.sh

echo "-------------------------------------------------"
echo " > Installing terraform"
echo "-------------------------------------------------"
echo " "
$PWD/local/terraform.sh

echo "-------------------------------------------------"
echo " > Insert GCP Auth"
echo "-------------------------------------------------"
echo " "
sudo nano $PWD/gcloud.json

echo "-------------------------------------------------"
read -p " > Insert project name (Default: k8s-devops-cf): " pjname
echo "-------------------------------------------------"
echo " "
sudo sed -i "s/$pjname/k8s-devops-cf/g" $PWD/terraform/variables.tf

echo "-------------------------------------------------"
read -p " > Insert ssh username (Default: gsmcfdevops): " sshusername
echo "-------------------------------------------------"
echo " "
sudo sed -i "s/$sshusername/gsmcfdevops/g" $PWD/terraform/variables.tf

echo "-------------------------------------------------"
read -p " > Insert Postgres password: " pgpass
echo "-------------------------------------------------"
echo " "
sudo sed -i "s/$pgpass/postgres_this_password_will_change/g" $PWD/ansible/roles/main/tasks/main.yml

echo "-------------------------------------------------"
read -p " > Insert Grafana password: " grafanapass
echo "-------------------------------------------------"
sudo sed -i "s/$grafanapass/grafana_this_password_will_change/g" $PWD/ansible/roles/k8smaster/tasks/main.yml

echo " "
echo " "
echo "-------------------------------------------------"
echo " > Script completed!"
echo "-------------------------------------------------"
echo " > GCloud CLI Version: $(gcloud --version | awk '{print $4}')"
echo " > Terraform Version: $(terraform --version | awk '{print $2}')"
echo " "
echo " > Project name: $pjname"
echo " > SSH username: $sshusername"
echo " > Postgres password: $pgpass"
echo " > Grafana password: $grafanapass"
echo "-------------------------------------------------"
echo " "
echo " "
sleep 4
