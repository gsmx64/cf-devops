#!/bin/bash

echo " "
echo "-------------------------------------------------"
echo " > Installing GCP CLI"
echo "-------------------------------------------------"
if [ "$(dpkg -l | awk '/google-cloud-cli/ {print }' | wc -l)" -ge 1 ]; then
    echo " > GCP CLI already installed"
else
    $PWD/local/gcloud_cli.sh
fi

echo " "
echo "-------------------------------------------------"
echo " > Installing terraform"
echo "-------------------------------------------------"
echo " "
if [ -f "/usr/bin/terraform" ]; then 
    echo " > Terraform already installed"
else
    $PWD/local/terraform.sh
fi

echo " "
echo "-------------------------------------------------"
echo " > Insert GCP Auth"
echo "-------------------------------------------------"
sleep 5
sudo nano $PWD/gcloud.json

echo " "
echo "-------------------------------------------------"
read -p " > Insert project name (Default: k8s-devops-cf): " pjname
echo "-------------------------------------------------"
if [ -n "$pjname" ]; then
    sudo sed -i "s/k8s-devops-cf/$pjname/g" $PWD/terraform/variables.tf
fi

echo " "
echo "-------------------------------------------------"
read -p " > Insert ssh username (Default: gsmcfdevops): " sshusername
echo "-------------------------------------------------"
if [ -n "$sshusername" ]; then
    sudo sed -i "s/gsmcfdevops/$sshusername/g" $PWD/terraform/variables.tf
fi

if [ ! -f "$PWD/$sshusername.pub" ]; then
    echo " "
    echo "-------------------------------------------------"
    echo " > Create ssh keys: "
    echo "-------------------------------------------------"
    ssh-keygen -t rsa -b 4096 -f $sshusername
fi

echo " "
echo "-------------------------------------------------"
read -p " > Insert Postgres password: " pgpass
echo "-------------------------------------------------"
if [ -n "$pgpass" ]; then
    sudo sed -i "s/postgres_this_password_will_change/$pgpass/g" $PWD/ansible/roles/main/tasks/main.yml
fi

echo " "
echo "-------------------------------------------------"
read -p " > Insert Grafana password: " grafanapass
echo "-------------------------------------------------"
if [ -n "$grafanapass" ]; then
    sudo sed -i "s/grafana_this_password_will_change/$grafanapass/g" $PWD/ansible/roles/k8smaster/tasks/main.yml
fi

echo " "
echo " "
echo "-------------------------------------------------"
echo " > Script completed!"
echo "-------------------------------------------------"
echo " > GCloud CLI Version: $(gcloud --version | awk '{print $4}')"
echo " > Terraform Version: $(terraform --version | awk '{print $2}' | tr --delete ' linux_amd64')"
echo " "
echo " > Project name: $pjname"
echo " > SSH username: $sshusername"
echo " > Postgres password: $pgpass"
echo " > Grafana password: $grafanapass"
echo "-------------------------------------------------"
echo " "
echo " "
sleep 4
