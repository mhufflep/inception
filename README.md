# inception

lftp -u ftp_user ftp://mhufflep.42.fr

for lftp (ftps)
set ssl:ca-file "/etc/ssl/certs/ca-certificates.crt"
or with self-signed
set ssl:ca-file "/home/mhufflep/data/certs/mhufflep_CA.crt"


sudo cp mhufflep_CA.crt /etc/ssl/certs/mhufflep_CA.pem
sudo update-ca-certificates
