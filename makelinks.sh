#/bin/bash

OPT=-nv
#HOST=archive.ubuntu.com

SITE=$1
GUID=$2

if [ -e allpackagefiles ]
then
	rm allpackagefiles
fi
touch allpackagefiles

GET http://$SITE/config/$GUID/repository.txt | sed s/ubuntu\-ports\\\/// | sed s/binary\-ppc/binary\-powerpc/ > allpackagefiles

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
 touch ${LOC}
 bzip2 -d < ${LOC}.bz2 | ./extractpackages.pl > ${LOC}
fi

#   done
 done

