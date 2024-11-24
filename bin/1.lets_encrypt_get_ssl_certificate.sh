#!/bin/bash 
#Script will generate ssl certificate for provided domain.
# 11/23/2024 MA update scritp to be executed by regular user 

echo "Enter your domain name to create let's encrypt certificagte: "
read DOMAIN
echo "Eneter your email address for let's encrypt account registration"
read EMAIL
echo "Eneter OCI ID of the Load Balancer"
read LB_OCIID

if [ ! -e~/bin/oci-lets-encrypt/etc ]; then 
  mkdir -p ~/bin/oci-lets-encrypt/etc
fi 

#Update configuration file 
touch ~/bin/oci-lets-encrypt/etc/oci_network.cfg
echo "LB_OCIID:"${LB_OCIID} >> ~/bin/oci-lets-encrypt/etc/oci_network.cfg

#Register account 
#ask user for email

sudo /usr/local/bin/certbot register -m ${EMAIL}  --agree-tos --non-interactive

#Create a certificat in default domain
#Get webroot directory for domain from nginx config file
# sudo /usr/local/bin/certbot register -m mantonik+letsencrypt@gmail.com  --agree-tos --non-interactive
# sudo /usr/local/bin/certbot certonly --dry-run --webroot -w /data/nginx/letsencrypt/ -d dmseo03.dmcloudarchitect.com
sudo /usr/local/bin/certbot certonly --webroot -w /data/nginx/letsencrypt/ -d ${DOMAIN}

#Check if certificate was created succesfully
sudo chmod 755 /etc/letsencrypt/live
if [ ! -e /etc/letsencrypt/live/${DOMAIN} ]; then 
  echo "Certificate was not created succesfully. Pleaes check why"
  echo "Missing folder /etc/letsencrypt/live/${DOMAIN}"
  exit
fi


~/bin/oci-lets-encrypt/bin/lets_encrypts_update_oci_lb_ssl_cert.sh ${DOMAIN}

sudo chmod 700 /etc/letsencrypt/live

echo "Exit"
exit


#chck if certificate is updated
# https://cameronnokes.com/blog/working-with-json-in-bash-using-jq/
#https://serverfault.com/questions/876944/jq-cannot-index-errors
# information about syntax for complext query 
#
# oci lb load-balancer get --load-balancer-id ${LB_OCIID}| jq -r '.data.listeners.[]'

#oci lb load-balancer get --load-balancer-id ${LB_OCIID}| jq -r '.data.listeners' |jq 'keys | .[]'
# "LS-http"
# "LS-https"

# oci lb load-balancer get --load-balancer-id ${LB_OCIID}| jq -r '.data.listeners' |jq 'length'


# oci lb load-balancer get --load-balancer-id ${LB_OCIID}| jq -r '.data.listeners.[].LS-https'



#get list of old certificates
#https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.4.4/oci_cli_docs/cmdref/lb/certificate/list.html
#oci lb certificate list --load-balancer-id ${LB_OCIID}
# oci lb certificate list --load-balancer-id ${LB_OCIID}|grep  certificate-name |grep -v ocidemo.ddns.net.${CERT_DT}| \
# jq -r '.data.listeners'

#oci lb certificate list --load-balancer-id ${LB_OCIID}|grep  certificate-name |grep -v ocidemo.ddns.net.${CERT_DT}|cut -d: -f2


#https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.4.4/oci_cli_docs/cmdref/lb/certificate/delete.html 
#oci lb certificate delete
# --certificate-name 
# --load-balancer-id ${LB_OCIID}




# /usr/local/bin/certbot --help

#renew certificate script

#auto update OCI LB wtih new SSL certificate

#renew certificate

#certbot renew --deploy-hook ./oci-lb-cert-renewal.sh

#oci-lb-cert-renewal.sh 

#1. Creates a cert bundle with the newly procured certificate from Let''s Encrypt at the LB.
#2. Updates the Listener (oci lb listener update) with this bundle.

#oci lb listener update
#listener LS-https
#--default-backend-set-name, --port, --protocol, --load-balancer-id, --listener-name



#3. Deletes (clean-up) any old certificate bundle from the LB (oci lb certificate delete).


#listener LS-https
#oci lb listener update)

