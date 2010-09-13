#/bin/bash

( for i in `./getrepo.pl` 
 do
    echo ${i} 
 done ) | POST -d http://`cat site.inf`/cgi-bin/repository.pl?guid=`cat system.inf`
