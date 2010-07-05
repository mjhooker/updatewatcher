#!/bin/bash

# dpkg-query -l | grep -v "^rc" > packages
# echo checking installed packages
dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages
gzip < packages > packages.gz

if [ -e packages.md5 ]
then

 OLD=`cat packages.md5`
 NEW=`md5sum packages`

 POST http://localhost/cgi-bin/packages.pl?guid=`cat system.inf` < packages

 if [[ ! ${NEW} == ${OLD} ]]
 then
  echo installed packages updated
  cp allpackagefiles newpackagefiles
# else
#  echo no change to installed packages
 fi
else
 cp allpackagefiles newpackagefiles
 echo checking all available packages
fi

if [ ! -e system.inf ]
then
 echo generating guid
 uuidgen > system.inf
fi

echo "${NEW}" > packages.md5
