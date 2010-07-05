#/bin/bash

OPT=-nv
#HOST=archive.ubuntu.com


rm allpackagefiles
touch updatedpackages
echo updatedpackages > newpackagefiles

for i in `./getrepo.pl` 
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
 echo ${LOC} >> newpackagefiles
fi

echo ${LOC} >> allpackagefiles

#   done
 done

POST http://localhost/cgi-bin/repository.pl?guid=`cat system.inf` < allpackagefiles
