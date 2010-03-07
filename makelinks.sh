#/bin/bash

OPT=-nv

rm allpackagefiles

for i in jaunty jaunty-security jaunty-updates 
 do
  for j in main multiverse universe restricted 
   do


wget $OPT -m http://archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages.bz2 
if [ archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages -nt archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages ]
then
 echo unzippping
 bzip2 -d < archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages.bz2 > archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages
fi

echo archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages >> allpackagefiles

    echo $j $i
   done
 done

