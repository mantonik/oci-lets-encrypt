#!/bin/bash

#Script will initialize account 
echo "Script will install required packages for certbot and setup certificate for"

# Install oci tools as root
echo "----" 
echo "Install OCI tools"
mkdir ~/install
cd ~/install
wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh
mv install.sh oci_install.sh
chmod 700 oci_install.sh
sudo rm 
./oci_install.sh --accept-all-defaults
rm -f ./oci_install.sh

#install cli from github directly
#bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh) --accept-all-defaults"


#Ceate rsa key for oci
mkdir ~/.oci
cd ~/.oci
# generate key with passphase
#openssl genrsa -out ~/.oci/oci_api_key.pem -aes128 2048   
# no passphrase 
openssl genrsa -out ~/.oci/oci_api_key.pem 2048   
chmod go-rwx ~/.oci/oci_api_key.pem  
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem 
 

echo "-----"
echo "Install Certboot"
sudo python -m ensurepip --upgrade
sudo get-pip.py
pip3 install certbot

#Create a root rsa key 
#ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa_rsync  -q -N ""
#cp ~/.ssh/id_rsa_rsync.pub /share/root_app1_id_rsa_rsync.pub
#chown 600 ~/.ssh/*