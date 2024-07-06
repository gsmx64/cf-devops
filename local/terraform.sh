#!/bin/bash

sudo apt-get remove terraform
sudo rm /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

if echo "$(lsb_release -r | awk '{print $2}')" | grep -q "23.04"; then
   git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
   echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
   ln -s ~/.tfenv/bin/* /usr/local/bin
   tfenv install latest
fi

terraform --version
sleep 4
