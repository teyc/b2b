#!/bin/bash

apt-get install letsencrypt
letsencrypt certonly -d readify-linux.australiaeast.cloudapp.azure.com

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

