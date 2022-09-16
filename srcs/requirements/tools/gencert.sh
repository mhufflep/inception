#!/bin/bash

# 0. Create Certificate Authority
openssl req -x509 \
    -sha256 -days 356 \
    -nodes \
    -newkey rsa:2048 \
    -subj "/CN=webserv.com/C=RU/L=Kazan" \
    -keyout rootCA.key -out rootCA.crt 

# Note: If you get the following error, comment RANDFILE = $ENV::HOME/.rnd line in /etc/ssl/openssl.cnf


# 1. Create the Server Private Key
openssl genrsa -out server.key 2048

# 2. Create Certificate Signing Request Configuration
echo \
"[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = RU
ST = RT
L = Kazan
O = 21 School
OU = 21 School Dev
CN = localhost

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = webserv.com
DNS.2 = localhost
IP.1 = 172.20.10.2
IP.2 = 127.0.0.1
" >> csr.conf

# 3. Generate Certificate Signing Request (CSR) Using Server Private Key
openssl req -new -key server.key -out server.csr -config csr.conf

# 4. Create a external file
echo \
"authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = webserv.com
DNS.2 = localhost
" > cert.conf

# 5. Generate SSL certificate With self signed CA
openssl x509 -req  \
    -in server.csr  \
    -CA rootCA.crt   \
    -CAkey rootCA.key \
    -CAcreateserial    \
    -sha256 \
    -days 365 \
    -out server.crt \
    -extfile cert.conf
