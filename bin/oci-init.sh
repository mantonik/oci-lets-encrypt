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

echo "Install required packages"
sudo dnf install -y oraclelinux-release-el8
sudo dnf config-manager --set-enabled ol8_developer_EPEL
sudo dnf clean all
#install required pacakes
#sudo dnf install -y nginx php php-fpm php-mysqlnd php-json sendmail htop tmux mc rsync clamav clamav-update rclone setroubleshoot-server setools-console 
sudo dnf install -y nginx sendmail htop tmux mc clamav clamav-update rclone setroubleshoot-server setools-console 
sudo chkconfig nginx on


echo "------"
echo "Install nginx"
echo "Create data directory for nginx"
sudo mkdir -p /data/nginx/html;
sudo mkdir -p /data/nginx/domain;
sudo mkdir -p /data/nginx/letsencrypt;

#echo "Copy default config to nginx folder"
sudo cp -rf /home/opc/bin/oci-lets-encrypt/server-config/* /

sudo service nginx restart

sudo systemctl stop firewalld
sudo systemctl disable firewalld
#sudo systemctl status firewalld


#Create a root rsa key 
#ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa_rsync  -q -N ""
#cp ~/.ssh/id_rsa_rsync.pub /share/root_app1_id_rsa_rsync.pub
#chown 600 ~/.ssh/*

# /usr/share/nginx/html