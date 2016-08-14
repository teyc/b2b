#!/bin/bash

# daemonize with
#     daemon -r ~/b2b/exercise/greet.sh

cd /home/chui/b2b/exercise/
nc -l 38105 < hello.txt
