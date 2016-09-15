#!/bin/bash

DOMAIN=`cat DOMAIN`

# Security sensitive!
groupadd b2busers

# Install letsencrypt
apt-get install letsencrypt


# Install docker
apt-get install apt-transport-https ca-certificates docker-engine
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
cp patch/docker.list /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install docker-engine
# TODO https://docs.docker.com/engine/installation/linux/ubuntulinux/

# Install certs if it is not present
if [ ! -f /etc/letsencrypt/live/$DOMAIN/cert.pem ]; then
   letsencrypt certonly -d $DOMAIN
else
   echo 'letsencrypt certificate already present.'
fi

if [ $? -ne 0 ]; then
    echo '=== HINT: OPEN PORT 443 on WindowsAzure ===='
    exit $?
fi

apt-get install daemon

# enable challenge password on /etc/ssh/ssh_config, and reload the config file
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
/etc/init.d/ssh reload

if [ ! -f web.py-0.38.tar.gz ]; then
   WEBPY_TGZ=web.py-0.38.tar.gz
   wget http://webpy.org/static/$WEBPY_TGZ
   tar zxf $WEBPY_TGZ
   ln -s web.py-0.38/web web.py
   chmod -R a+rw web/

   # patch ssl_certificate_chain
   cp patch/httpserver.py web.py-0.38/web/.

fi

# run the user service as a daemon, restarts automatically
daemon -r -n app.py -D `pwd` /usr/bin/python app.py 443

# run self test
echo "Self test"
curl -i https://$DOMAIN/hello
