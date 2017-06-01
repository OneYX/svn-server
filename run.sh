#!/bin/bash
exec sudo docker run -i -t -p80:80 wax/svn-server /startup.sh $1
