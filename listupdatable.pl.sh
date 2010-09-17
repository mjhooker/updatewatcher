#!/bin/bash

if [ ! -e system.inf ]
then
 echo generating guid
 uuidgen > system.inf
fi



if [ -e site.inf ]
then

if [ -e machine.inf ]
then

if [ -e account.inf ]
then

ADDR=http://`cat site.inf`/cgi-bin/
GUID=\?guid=`cat system.inf`


# ./makelinks.sh

( for i in `./getrepo.pl` 
 do
    echo ${i} 
 done ) | POST -d ${ADDR}repository.pl${GUID}

# ./getpackages.sh

dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages

OLD=`cat packages.md5`
NEW=`md5sum packages`
echo "${NEW}" > packages.md5



 if [[ ! ${NEW} == ${OLD} ]]
 then
 # installed packages updated

  POST -d ${ADDR}packages.pl${GUID} < packages

 fi


POST -d ${ADDR}machine.pl${GUID} < machine.inf
POST -d ${ADDR}account.pl${GUID} < account.inf



else
 echo please provide account email address in account.inf
fi




else
 echo please set machine descriptor in machine.inf
fi



else
 echo please set site name in site.inf
fi

