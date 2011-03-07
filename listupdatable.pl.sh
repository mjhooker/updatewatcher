#!/bin/bash

CONFIG=siteinf.sh

if [ -e $CONFIG ]
then

source $CONFIG

GUID=\?guid=${MGUID}

echo ${MACH} | POST -d ${ADDR}machine.pl${GUID}
echo ${ACC} | POST -d ${ADDR}account.pl${GUID}


# ./makelinks.sh

( for i in `./getrepo.pl` 
 do
    echo ${i} 
 done ) | POST -d ${ADDR}repository.pl${GUID}

# ./getpackages.sh

dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" | POST -d ${ADDR}packages.pl${GUID}

else
 echo needs $CONFIG file
 read -p "enter site name:" -e SITE
 ADDR=https://${SITE}/cgi-bin
 MGUID=`GET ${ADDR}/newguid.pl`
 echo guid is $MGUID
 read -p "enter machine name:" -e MACH
 read -p "enter account email address:" -e ACC

 echo "MGUID=$MGUID" > siteinf.sh
 echo "ADDR=${ADDR}" >> siteinf.sh
 echo "MACH=\"$MACH\"" >> siteinf.sh
 echo "ACC=${ACC}" >> siteinf.sh 

fi
