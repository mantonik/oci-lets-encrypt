# oci-lets-encrypt
Scripts to create a lets encrypt certificate and update load balancer

unzip this package to bin folder 
it will create a folder oci-lets-encrytp 
with subset of the folders where you will configure envirement 

start with oci-init.sh script - script will install required packaged for oci, setup a rsa key and install certboot.

oci-init.sh 

User generate key to create API key on your account - admin account which have access to manage load balancer


Download zip from repository 

#setup this as opc user

mkdir bin 
cd bin 
rm -rf oci-lets-encrypt-main
wget https://github.com/mantonik/oci-lets-encrypt/archive/refs/heads/main.zip
unzip main.zip 
rm -f main.zip
chmod 755 oci-lets-encrypt-main/bin/*.sh


