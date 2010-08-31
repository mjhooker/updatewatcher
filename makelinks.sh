#/bin/bash

#OPT=-nv
#HOST=archive.ubuntu.com


rm allpackagefiles

for i in `./getrepo.pl` 
 do
    LOC=${i}
    echo ${LOC} >> allpackagefiles

#   done
 done

POST -d http://`cat site.inf`/cgi-bin/repository.pl?guid=`cat system.inf` < allpackagefiles
