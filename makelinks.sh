#/bin/bash

rm allpackages

for i in jaunty jaunty-security jaunty-updates 
 do
  for j in main multiverse universe restricted 
   do


wget -nv -m http://archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages.bz2 
bzip2 -d < archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages.bz2 > archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages
cat archive.ubuntu.com/ubuntu/dists/${i}/${j}/binary-i386/Packages >> allpackages

    echo $j $i
   done
 done

