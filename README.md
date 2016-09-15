Linux for .NET developers
========================================

  1. Install Windows GIT

  2. Start the bash shell

  3. Get a login and password for the system using

        curl -X POST https://SERVERNAME/adduser

  4. Follow the instructions to generate your own
     key pair and configure your logon to using
     keys rather than password

  

For administrators Configuration
========================================
 
  Set up the machine by running

    sudo ./reset-the-world.sh

  This should automatically run up the web service.
  If you need to do this manually, refer to

    ssh -i ~/.ssh/id_rsa chui@SERVER
    cd b2b
    sudo python app.py 443

