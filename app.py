import web
import random
import crypt
import os

domain = open('DOMAIN', 'r').readline().strip()
print 'Domain: ' + domain

from web.wsgiserver import CherryPyWSGIServer
cert_path = '/etc/letsencrypt/live/%s' % domain
server_name = domain
 
# curl can't work with cert.pem?
CherryPyWSGIServer.ssl_certificate = '%s/cert.pem' % cert_path
CherryPyWSGIServer.ssl_certificate_chain = '%s/fullchain.pem' % cert_path
CherryPyWSGIServer.ssl_private_key = '%s/privkey.pem' % cert_path

urls = ("/adduser", "adduser",
	"/.*", "hello")

app = web.application(urls, globals())

class hello:
  def GET(self):
    return "Hello world"

class adduser:
  def POST(self):
     #os.system('useradd 
     adjectives = open('adjectives.txt', 'r').readlines()
     animals = open('animals.txt', 'r').readlines()
     animal = random.choice(animals).strip().lower()
     adjective = random.choice(adjectives).strip()
     username = "%s-%s" % (adjective, animal)
     salt = "".join([random.choice(adjective) for i in range(3)])
     password = "".join([random.choice('abcdefgh0123456789ABCDEFGHIJLKMSQPZ') for i in range(8)])
     passwordc = crypt.crypt(password, salt)
     os.system('useradd -s /bin/bash -m -p %s %s' % (passwordc, username))
     return """
Your username is %s
password is %s
You can now connect to a secure shell using
$ ssh %s@%s
$ 
$ # and set up passwordless login by putting your keys in ~/.ssh/authorized_keys
$ mkdir ~/.ssh
$ logout
$ #
$ # generate key pair on your local machine
$ #
$ ssh-keygen -f work_rsa
$
$ # copy the public key over a secure connection and put it in ~/.ssh/authorized_keys
$ scp work_rsa.pub %s@readify-b2b.australiaeast.cloudapp.azure.com:.ssh/authorized_key
$
$ # you can now log in using key file rather than password
$ ssh -i work_rsa %s@readify-b2b.australiaeast.cloudapp.azure.com
""" % (username, password, username, server_name, username, username)
       
if __name__ == "__main__":
  app.run()

