#!/bin/bash



if [ -e site.inf ]
then

SITE=`cat site.inf`

for i in `GET http://$SITE/cgi-bin/guidlist.bash`
do

#echo $i

./makelinks.sh $SITE $i
./getpackages.sh $SITE $i
./readpkg.pl $SITE $i

POST http://$SITE/cgi-bin/updateable.pl?guid=$i < updatedpackages.html > /dev/null

done

else
 echo please set site name in site.inf
fi


rm allpackagefiles updatedpackages.html
rm packages