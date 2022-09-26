# Shared folder

1. First of all you need to enable directory sharing and add shared folder in the settings of your VM

2. Install this tools (as for me, they were already installed)
```bash
sudo apt install spice-vdagent spice-webdavd davfs2
```

3. Check sharing webdav server is working accessing this url should give you list of the files in the directory you specified as shared in UTM settings of the VM
```bash
curl http://127.0.0.1:9843/
```

4. Mount this address to a folder
```bash
sudo mkdir -p /mnt/shared
sudo mount -t davfs -o noexec http://127.0.0.1:9843/ /mnt/shared/
```

5. Optional.  I did not used these steps, but if you’re getting prompted, try this (replace login and pass by your credentials):
```bash
sudo cat >> /etc/davfs2/secrets << EOF
# mounted UTM directory
/mnt/shared login pass
EOF
```

6. Optional. To mount every time automatically add these lines:
```bash
sudo cat >> /etc/fstab << EOF
# mounted UTM directory
http://127.0.0.1:9843/ /mnt/shared davfs _netdev,user 0 0
EOF
```