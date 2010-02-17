#!/bin/bash

# dpkg-query -l | grep -v "^rc" > packages
dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages
gzip < packages > packages.gz
