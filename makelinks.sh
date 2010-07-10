#/bin/bash

OPT=-nv
#HOST=archive.ubuntu.com

SITE=$1
GUID=$2

rm allpackagefiles
touch allpackagefiles

GET http://$SITE/config/$GUID/repository.txt > allpackagefiles

for i in `cat allpackagefiles` 
 do
#  for j in main multiverse universe restricted 
#   do

#    echo check for updated $i


    LOC=${i}
wget $OPT -m http://${LOC}.bz2 
if [ ${LOC}.bz2 -nt ${LOC} ]
then
 echo unzippping updated $i
 bzip2 -d < ${LOC}.bz2 > ${LOC}
fi

#   done
 done

