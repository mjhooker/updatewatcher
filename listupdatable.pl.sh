#!/bin/bash

if [ -e site.inf ]
then

SITE=`cat site.inf`

for i in `GET https://$SITE/cgi-bin/guidlist.bash`
do

#echo $i

./makelinks.sh $SITE $i

#./getpackages.sh $SITE $i

GET https://$SITE/config/$i/packages.txt > packages
GET https://$SITE/cgi-bin/packages_date.pl??guid=$i > packages_date
GET https://$SITE/config/$i/machine.txt > machine.txt

./readpkg.pl

POST https://$SITE/cgi-bin/updateable.pl?guid=$i < updatedpackages.html > /dev/null
POST https://$SITE/cgi-bin/repo.pl?guid=$i < repo.html > /dev/null

done

else
 echo please set site name in site.inf
fi

rm allpackagefiles updatedpackages.html
rm packages