#!/bin/bash


if [ -e site.inf ]
then

./makelinks.sh
./getpackages.sh
./readpkg.pl
POST http://`cat site.inf`/cgi-bin/updateable.pl?guid=`cat system.inf` < updatedpackages.html


else
 echo please set site name in site.inf
fi


