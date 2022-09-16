#!/bin/sh

sudo apt-get update && apt-get upgrade && apt-get install curl openvpn unzip

cd /tmp \
    && wget https://files.ovpn.com/ubuntu_cli/ovpn-se-gothenburg.zip \
    && unzip ovpn-se-gothenburg.zip \
    && mkdir -p /etc/openvpn && mv config/* /etc/openvpn \
    && chmod +x /etc/openvpn/update-resolv-conf \
    && rm -rf config \
    && rm -f ovpn-se-gothenburg.zip

echo "mhufflep" >> /etc/openvpn/credentials
echo "" >> /etc/openvpn/credentials

# IMPORTANT
# ! do not forget to change password !
# ! install appropriate ssh-key as well !
# ! vpnconfig should be copied to the host machine !

# START VPN
# openvpn --config /etc/openvpn/ovpn.conf --daemon

# CHECK
# git clone intra-repo.git

# USEFUL
# systemctl start openvpn    # Starts OpenVPN and connects to OVPN
# systemctl stop openvpn     # Stops OpenVPN
# systemctl restart openvpn  # Restarts OpenVPN
# systemctl status openvpn   # Shows status for OpenVPN
