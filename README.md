# oci-lets-encrypt
Scripts to create a lets encrypt certificate and update load balancer

unzip this package to bin folder 
it will create a folder oci-lets-encrytp 
with subset of the folders where you will configure envirement 



User generate key to create API key on your account - admin account which have access to manage load balancer


Download zip from repository 

#setup this as opc user

mkdir ~/bin 
cd ~/bin 
rm -rf oci-lets-encrypt-main
rm -rf oci-lets-encrypt
wget https://github.com/mantonik/oci-lets-encrypt/archive/refs/heads/main.zip
unzip main.zip 
rm -f main.zip
chmod 755 oci-lets-encrypt-main/bin/*.sh
cd ~/bin 
mv oci-lets-encrypt-main oci-lets-encrypt

#Generate a key
/home/opc/bin/oci-lets-encrypt-main/bin/oci-init.sh 
touch ~/.oci/config
cat ~/.oci/oci_api_key_public.pem
chmod 600 ~/.oci/*

Login to OCI console and add API key 

My Profile
API keys

copy popup message to config file

Replace line 
key_file=<path to your private keyfile> # TODO

with  (adust path if you using different user)                                  
key_file=/home/opc/.oci/oci_api_key.pem

Validate connection to OCI 

oci os ns get

# Generate certificate
# Script need to be run as user with sudo access 
~/bin/oci-lets-encrypt/bin/1.lets_encrypt_get_ssl_certificate.sh


LB
dmseo03.dmcloudarchitect.com
mantonik@gmail.com
ocid1.loadbalancer.oc1.us-sanjose-1.aaaaaaaajk2dwost2qsmsqifdlf65g64ub6a6ugodcwewixcv5gfy4xkichq
