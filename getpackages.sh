#!/bin/bash

# dpkg-query -l | grep -v "^rc" > packages
# echo checking installed packages
dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages
#gzip < packages > packages.gz

OLD=`cat packages.md5`
NEW=`md5sum packages`
echo "${NEW}" > packages.md5

if [ -e packages.md5 ]
then



 if [[ ! ${NEW} == ${OLD} ]]
 then
  echo installed packages updated

  POST -d http://`cat site.inf`/cgi-bin/packages.pl?guid=`cat system.inf` < packages

# else
#  echo no change to installed packages
 fi
fi


