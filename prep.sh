#!/bin/bash

apt-get install letsencrypt
letsencrypt certonly -d readify-b2b.australiaeast.cloudapp.azure.com

apt-get install daemon

# enable challenge password on /etc/ssh/ssh_config
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config

python app.py 443

