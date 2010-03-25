#/bin/bash

OPT=-nv
HOST=archive.ubuntu.com


rm allpackagefiles
rm newpackagefiles

for i in jaunty jaunty-security jaunty-updates 
 do
  for j in main multiverse universe restricted 
   do

    LOC=${HOST}/ubuntu/dists/${i}/${j}/binary-i386/Packages
wget $OPT -m http://${LOC}.bz2 
if [ ${LOC}.bz2 -nt ${LOC} ]
then
 echo unzippping
 bzip2 -d < ${LOC}.bz2 > ${LOC}
 echo ${LOC} >> newpackagefiles
fi

echo ${LOC} >> allpackagefiles

    echo updated $j $i
   done
 done

