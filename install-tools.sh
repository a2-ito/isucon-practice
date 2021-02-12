#!/bin/bash

# docker

# netdata
echo '#######################################################################'
echo '# install netdata'
echo '#######################################################################'
docker run -d --name=netdata \
  -p 19999:19999 \
  -v netdataconfig:/etc/netdata \
  -v netdatalib:/var/lib/netdata \
  -v netdatacache:/var/cache/netdata \
  -v /etc/passwd:/host/etc/passwd:ro \
  -v /etc/group:/host/etc/group:ro \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /etc/os-release:/host/etc/os-release:ro \
  --restart unless-stopped \
  --cap-add SYS_PTRACE \
  --security-opt apparmor=unconfined \
  netdata/netdata	

# alp
echo '#######################################################################'
echo '# install alp'
echo '#######################################################################'
wget -q https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip -o alp_linux_amd64.zip
sudo -E install ./alp /usr/local/bin/alp

# slackcat
#wget https://github.com/bcicen/slackcat/releases/download/v1.6/slackcat-1.6-linux-amd64
#sudo -E install ./slackcat-1.6-linux-amd64 /usr/local/bin/slackcat

# pt-query-digest
wget https://www.percona.com/downloads/percona-toolkit/3.0.10/binary/debian/xenial/x86_64/percona-toolkit_3.0.10-1.xenial_amd64.deb
sudo apt install -y libdbd-mysql-perl libdbi-perl libio-socket-ssl-perl libnet-ssleay-perl libterm-readkey-perl
sudo dpkg -i percona-toolkit_3.0.10-1.xenial_amd64.deb

