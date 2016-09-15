Linux for .NET developers
========================================

  1. Install Windows GIT

  2. Start the bash shell

  3. Get a login and password for the system using

         curl -X POST https://SERVERNAME/adduser

  4. Follow the instructions to generate your own
     key pair and configure your logon to using
     keys rather than password

  5. Once logged in clone this repository

         git clone git@github.com:teyc/b2b.git  

  6. Then go to the exercise directory

         cd b2b/exercise


  7. First commands

         cal
	 echo Microsoft loves linux
         cat hello.txt
         more /usr/share/doc/adduser/examples/README
         man more
	 pwd
         ls ~
         ls -l /bin/net*

  8. Identify the Read Write Executable bits when you
     list files in a directory. Observe that greet.sh
     is executable. Try running it.

         ./greet.sh

  9. You can modify the executable bit by using `chmod`

         chmod uga-x greet.sh

  10. Run tasks in the foreground

         sleep 5; echo I have snoozed enough!


  11. Run tasks in the background


         bash -c "sleep 5; echo I have snoozed enough!" &
	 cal
         cal

  12. Use `history` to get your past commands,
      and use bang number e.g. !5 to run command number 5.
  

  13. Use bang and first few letters e.g. !ps works as well

 
  14. Use arrow up and down, and CTRL+A and CTRL+E to
      move to start and end of line

  15. Try

         ifconfig
         find .. -iname '*.md'
         which docker

  16. Write a telnet service!

      echo "Microsoft <3 Linux" > hello.txt
   
      nc -l 58016 < hello.txt &

      telnet localhost 58016


  17. Daemonize it


      echo '#!/bin/bash
      nc -l 58016 < hello.txt
      ' > greet.sh

      chmod a+x greet.sh

      daemon -r -D `pwd` ./greet.sh

      # you can connect to your network service
      # using a telnet or nc
      nc localhost 58016    

  18. You can turn this into a HTTP service

	      echo 'HTTP/1.0 200 OK
	      Content-Type: text/plain

	      Microsoft Loves Linux' > hello.html

      Then check it out using curl

          curl http://localhost:58016/

  19. Clear the screen using `CTRL+L`


Task Manager
---------------------

  1. top

  2. htop

  3. dstat

  4. strace ls
     strace python

  5. netstat -ae

  6. opensnoop 

     What's opening and closing the .txt files?

     opensnoop '.txt$' 
 
Palette cleanser
---------------------

  1. Enough Linux?

          sudo docker run -it microsoft/dotnet
          cd ~
          dotnet new
          dotnet restore
          dotnet build
          dotnet run
          ls -l

  2. To log out from docker, use CTRL+D


  3. To log out from your session, use CTRL+D


  4. Note, this machine has 2GB memory, docker 
     is virtualization without the overhead

For administrators Configuration
========================================
 
  Set up the machine by running

    sudo ./reset-the-world.sh

  This should automatically run up the web service.
  If you need to do this manually, refer to

    ssh -i ~/.ssh/id_rsa chui@SERVER
    cd b2b
    sudo python app.py 443

