#!/bin/bash

echo " > Updating Ubuntu/Debian."
sudo apt-get update
echo " > Installing the necessary packages."
sudo apt-get install apt-transport-https ca-certificates gnupg curl
echo " > Downloading the lastest version of gcloud cli."
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli google-cloud-cli-terraform-validator kubectl
echo " > Verifying the gcloud cli version."
gcloud --version
#echo " > Init gcloud."
#gcloud init
sleep 4
