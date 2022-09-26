# inception

## Description

The aim of this project is to build and up the following services using docker-compose:
- MariaDB
- Wordpress
- NGiNX
- Adminer
- FTP
- Redis Cache
- Cadvisor
- Prometheus

As a one of the bonus, there is also a static webpage.
## VM

If your device has x86 arch, use VirtualBox. (use `uname -m`)

I have used Macbook with M1 chip (ARM64), and if you want to do this project on M1 either, read the following:

VirtualBox is not supported ARM, and as I read from the forum, they are not planning to do ARM version of it.

[UTM](https://mac.getutm.app/) turned out to be a great replacement for VB.

Once installed go the the [gallery](https://mac.getutm.app/gallery/) and select the image of the VM.

My choice was Debian 10.4 (LDXE), you can choose another. Even MacOS can be installed over your MacOS :)

To install shared folder, use [this](/SHARED_FOLDER.md) instruction.

Official docker docs [says](https://docs.docker.com/desktop/mac/apple-silicon/) :
> Some command line tools do not work when Rosetta 2 is not installed. <br>
The old version 1.x of docker-compose. We recommend that you use Compose V2 instead. <br>
Either type docker compose or enable the Use Docker Compose V2 option in the General preferences tab.

I decided to work with `docker compose` instead of `docker-compose` and it worked great for me.

Installation process of the docker is the same as for x86. 

:warning: Do not forget to add docker group to current user

## Some tips & info

.env file contains sensitive data as enviroment variables
It is present in the repo only because the project is educational.
Never store prod .env file in the repo!

Before writing Dockerfiles read about PID 1, and daemons:
- [Post One](https://it-lux.ru/docker-entrypoint-pid-1/#1-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D1%8B-entrypoint-ampamp-cmd)
- [Post Two](https://medium.com/hackernoon/my-process-became-pid-1-and-now-signals-behave-strangely-b05c52cc551c)

- [CMD vs ENTRYPOINT](https://habr.com/ru/company/southbridge/blog/329138/)

In all the containers I have used `envsubst` to replace env variables in config files.

### MariaDB
This is the first service you should up, because for mandatory part you have dependency chain:

MariaDB -> Wordpress -> Nginx

For some reason, I could not install MariaDB on alpine 3.14, so I used alpine 3.7 for this container.

### Wordpress

Wordpress is working under `php-fpm`, so I proxied to wordpress:port with `fastcgi_pass`

### Nginx

I used a [bash script](/srcs/requirements/tools/gencert.sh) to generate SSL\TLS certificates.

This script is called from Makefile and produces CA key, CA certificate, server key and server certificate.

Certificates passed to containers through separate volume.

You can manually add CA certificate to the browser to avoid 'insecure' error.

[Add certificate to Mozilla Firefox](https://docs.vmware.com/en/VMware-Adapter-for-SAP-Landscape-Management/2.1.0/Installation-and-Administration-Guide-for-VLA-Administrators/GUID-0CED691F-79D3-43A4-B90D-CD97650C13A0.html)

As for Nginx, `ssl_protocols TLSv1.2 TLSv1.3;` must be specified in config file.

In this project nginx is the entry point to all the services, except ftp.

### Adminer

Adminer is working under `php-fpm` as well, so I proxied to adminer:port with `fastcgi_pass`
But you can start it under `php` and proxy with `proxy_pass` 

### Redis

Redis running in the separate container, and should be installed and activated as a wordpress plug-in.

### FTP

FTP's 21 port is forwarded as well as the passive ftp ports.

As for ftp client, I used [lftp](https://lftp.yar.ru/)
lftp is a terminal client supporting a number of network protocols (ftp, http, sftp, fish, torrent).

Here is some of the simple commands to 
```bash
# First, connect to some ftp server:
# lftp -u ftp_user ftp://mhufflep.42.fr

# ls               # List files
# put <file_path>  # Upload file
# get <file_path>  # Download file
# rm  <file_path>  # Remove file
```

For self-signed certificates with local CA, add this line to lftp config (`/etc/lftp.conf` on my system):
```conf
set ssl:ca-file "/etc/ssl/certs/ca-certificates.crt"
```

### cAdvisor & Prometheus

The info about these services could be found on the official pages:
[cAdvisor](https://github.com/google/cadvisor)
[prometheus](https://prometheus.io/docs/introduction/overview/)

Both of them are builded directly from github repo.


