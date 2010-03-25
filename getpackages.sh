#!/bin/bash

# dpkg-query -l | grep -v "^rc" > packages
echo checking installed packages
dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages
gzip < packages > packages.gz

if [ -e packages.gz.md5 ]
then
 if [ `md5sum --status -c packages.gz.md5` ]
 then
  echo installed packages updated
  cp allpackagefiles newpackagefiles
 fi
else
 cp allpackagefiles newpackagefiles
fi

if [ ! -e system.inf ]
then
 echo generating guid
 uuidgen > system.inf
fi

md5sum packages.gz > packages.gz.md5
