#!/bin/bash


if [ -e site.inf ]
then

./makelinks.sh
./getpackages.sh


else
 echo please set site name in site.inf
fi


