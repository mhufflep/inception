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

If your device has x86 arch, use VirtualBox and skip this block. (use `uname -m`, padawan)

I've done this project using Macbook Air (M1, ARM64)

<details>
<summary>If you want to do this project on M1 either, read the spoiler:</summary>

### UTM

VirtualBox is not supported ARM, and as I read from the forum, they are not planning to do ARM version of it.

[UTM](https://mac.getutm.app/) turned out to be a great replacement for VB.

Once installed go the the [gallery](https://mac.getutm.app/gallery/) and select the image of the VM. <br>
My choice was Debian 10.4 (LDXE), you can choose another. Even MacOS can be installed over your MacOS :)

To install shared folder, use [this](/SHARED_FOLDER.md) instruction.

<hr>

### Docker

Official docker docs [says](https://docs.docker.com/desktop/mac/apple-silicon/) :
> Some command line tools do not work when Rosetta 2 is not installed. <br>
The old version 1.x of docker-compose. We recommend that you use Compose V2 instead. <br>
Either type docker compose or enable the Use Docker Compose V2 option in the General preferences tab.

I decided to work with `docker compose` instead of `docker-compose` and it worked excellent.

</details>

:warning: Do not forget to add docker group to current user!

## Info, tips & links

```
.env file contains sensitive data in the enviroment variables.
Never store production environment and any important data in the repo!
```

Before writing Dockerfiles read the following and understand the concept of docker-init:
- [How to write your daemon](http://www.netzmafia.de/skripten/unix/linux-daemon-howto.html)
- [PID 1 and daemons](https://it-lux.ru/docker-entrypoint-pid-1/#1-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D1%8B-entrypoint-ampamp-cmd)
- [PID 1 and daemons](https://medium.com/hackernoon/my-process-became-pid-1-and-now-signals-behave-strangely-b05c52cc551c)
- [CMD vs ENTRYPOINT](https://habr.com/ru/company/southbridge/blog/329138/)

In all the containers I have used `envsubst` to replace env variables in the config files.

<hr>

### MariaDB
This is the first service you should up, because for mandatory part you have dependency chain:

MariaDB -> Wordpress -> Nginx

I could not install MariaDB on alpine 3.14, so I used alpine 3.7 for this container.

<hr>

### Wordpress

Wordpress is working under `php-fpm`, so I proxied to wordpress:port with `fastcgi_pass`.

Go ahead and take a look at a [useful site](https://wp-kama.ru/handbook/wp-cli) with a descriptions of wp-cli commands.

<hr>

### Nginx

I've used a [bash script](/srcs/requirements/tools/gencert.sh) to generate certificates.

This script is called from the Makefile and it produces CA key, CA crt, server key and server crt files. <br>
Certificates passed to containers through separate volume.

You can manually add CA certificate to the browser to avoid 'insecure' error.
[Add certificate to Mozilla Firefox](https://docs.vmware.com/en/VMware-Adapter-for-SAP-Landscape-Management/2.1.0/Installation-and-Administration-Guide-for-VLA-Administrators/GUID-0CED691F-79D3-43A4-B90D-CD97650C13A0.html)

As for Nginx, `ssl_protocols TLSv1.2 TLSv1.3;` must be specified in config file.

In this project nginx is the entry point to all the services, except ftp.

<hr>

### Adminer

Adminer is working under `php-fpm` as well, so I proxied to adminer:port with `fastcgi_pass`.
You can also start it under `php` and proxy with `proxy_pass` 

<hr>

### Redis

Redis running in the separate container, and should be installed and activated as a wordpress plug-in.

It is OK for `protected-mode no` to be set in the `redis.conf`, as container is working only in the internal network <br>
and has no access point from outside.

<hr>

### FTP

Port 21 and a range of passive ports are opened for FTP, see [docker-compose.yml](/srcs/docker-compose.yml#L184)

As for ftp client, I used [this](https://lftp.yar.ru/) called lftp.<br>
lftp is a terminal client that supports a number of network protocols (ftp, http, sftp...).

Here is some examples of lftp usage:
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
- [cAdvisor](https://github.com/google/cadvisor)
- [prometheus](https://prometheus.io/docs/introduction/overview/)

Both of them are builded directly from their github repos.


