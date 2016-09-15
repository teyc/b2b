#!/bin/bash

DOMAIN=`cat DOMAIN`

# Install letsencrypt
apt-get install letsencrypt

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

# enable challenge password on /etc/ssh/ssh_config
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config

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
