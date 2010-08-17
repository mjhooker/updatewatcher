#!/bin/bash

if [ ! -e system.inf ]
then
 echo generating guid
 uuidgen > system.inf
fi



if [ -e site.inf ]
then

if [ -e machine.inf ]
then

if [ -e account.inf ]
then


./makelinks.sh
./getpackages.sh
POST http://`cat site.inf`/cgi-bin/machine.pl?guid=`cat system.inf` < machine.inf
POST http://`cat site.inf`/cgi-bin/account.pl?guid=`cat system.inf` < account.inf



else
 echo please provide account email address in account.inf
fi




else
 echo please set machine descriptor in machine.inf
fi



else
 echo please set site name in site.inf
fi

