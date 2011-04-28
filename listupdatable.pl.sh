#!/bin/bash

echo "1;" > repochecked.inc

if [ -e site.inf ]
then

SITE=`cat site.inf`

for i in `GET https://$SITE/cgi-bin/guidlist.bash`
do

#echo checking $i

./makelinks.sh $SITE $i

#./getpackages.sh $SITE $i

GET https://$SITE/cgi-bin/packages_date.pl?guid=$i > packages_date
GET https://$SITE/cgi-bin/updatable_date.pl?guid=$i > updatable_date

if [ `cat packages_date` -ge `cat updatable_date` ] || [ `cat latest_date` -ge `cat updatable_date` ]


then

echo generating packages
GET https://$SITE/config/$i/packages.txt > packages
GET https://$SITE/config/$i/machine.txt > machine.txt

./readpkg.pl

POST https://$SITE/cgi-bin/updateable.pl?guid=$i < updatedpackages.html > /dev/null
POST https://$SITE/cgi-bin/repo.pl?guid=$i < repo.html > /dev/null
rm updatedpackages.html

fi

done

else
 echo please set site name in site.inf
fi

rm -f allpackagefiles packages

