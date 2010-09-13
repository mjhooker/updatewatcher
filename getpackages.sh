#!/bin/bash

dpkg-query -W -f '${Status;1}\t${Package}\t${Version}\n' | grep -v "^d" > packages

OLD=`cat packages.md5`
NEW=`md5sum packages`
echo "${NEW}" > packages.md5



 if [[ ! ${NEW} == ${OLD} ]]
 then
 # installed packages updated

  POST -d http://`cat site.inf`/cgi-bin/packages.pl?guid=`cat system.inf` < packages

 fi
