#!/bin/bash

KEY_DIR=private
CRT_DIR=certs

mkdir -p ${KEY_DIR} ${CRT_DIR}

CA_cert=mhufflep_CA.crt
CA_pkey=mhufflep_CA.key

SRV_cert=${CRT_DIR}/server.crt
SRV_pkey=${KEY_DIR}/server.key
SRV_csr=server.csr

CSR_conf=csr.conf
EXT_conf=cert.conf

DOMAIN=$1
DOMAIN_IP=$2

echo "# 0. Create Certificate Authority"
openssl req -x509 \
    -sha256 -days 356 \
    -nodes \
    -newkey rsa:2048 \
    -subj "/CN=${DOMAIN}/C=RU/L=Kazan" \
    -keyout ${CA_pkey} -out ${CA_cert} 

echo "# 1. Create the Server Private Key"
openssl genrsa \
    -out ${SRV_pkey} 2048

echo "# 2. Create Certificate Signing Request Configuration"
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
OU = Eternity
CN = localhost

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ${DOMAIN}
DNS.2 = localhost
IP.1 = ${DOMAIN_IP}
IP.2 = 127.0.0.1
" > ${CSR_conf}

echo "# 3. Generate Certificate Signing Request (CSR) Using Server Private Key"
openssl req -new \
    -key ${SRV_pkey} \
    -out ${SRV_csr} \
    -config ${CSR_conf}

echo "# 4. Create a configuration file containing certificate and request X.509 extensions to add."
echo \
"authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}
DNS.2 = localhost
" > ${EXT_conf}

echo "# 5. Generate SSL certificate With self signed CA"
openssl x509 -req  \
    -in ${SRV_csr}  \
    -CA ${CA_cert}   \
    -CAkey ${CA_pkey} \
    -CAcreateserial    \
    -sha256 \
    -days 365 \
    -out ${SRV_cert} \
    -extfile ${EXT_conf}

echo "# 6. Remove unnecessary files"
rm -f ${EXT_conf}
rm -f ${CSR_conf}
rm -f ${SRV_csr}