#!/bin/bash

DOMAIN=`cat DOMAIN`

# Install letsencrypt
apt-get install letsencrypt

# Install certs
letsencrypt certonly -d $DOMAIN
if [ $? -ne 0 ]; then
    echo '=== HINT: OPEN PORT 443 on WindowsAzure ===='
    exit $?
fi

apt-get install daemon

# enable challenge password on /etc/ssh/ssh_config
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config

if [ ! -f web.py-0.38.tar.gz ]; then
   WEBPY_TGZ=web.py-0.38.tar.gz
   wget http://webpy.org/static/$WEBPY_TGZ
   tar zxf $WEBPY_TGZ
   ln -s web.py-0.38/web web.py
fi

python app.py 443

