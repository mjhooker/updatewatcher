#!/bin/bash

source siteinf.sh

echo ${MACH} | POST -d ${ADDR}machine.pl${GUID}
echo ${ACC} | POST -d ${ADDR}account.pl${GUID}


# ./makelinks.sh

( for i in `./getrepo.pl` 
 do
    echo ${i} 
 done ) | POST -d ${ADDR}repository.pl${GUID}

# ./getpackages.sh

dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" | POST -d ${ADDR}packages.pl${GUID}

