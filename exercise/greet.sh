#!/bin/bash

# daemonize with
#     daemon -D `pwd` -r ~/b2b/exercise/greet.sh

nc -l 38105 < hello.txt
