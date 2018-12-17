#!/bin/bash
#
# Generate a self-signed SSL certificate

if [ -z "$1" ]
  then
    echo "Please provide a domain"
fi

cd $(dirname $0)

domain=$1

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./../certs/${domain}.key -out ./../certs/${domain}.crt