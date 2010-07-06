#!/bin/bash

./makelinks.sh
./getpackages.sh
./readpkg.pl
POST http://`cat site.inf`/cgi-bin/updateable.pl?guid=`cat system.inf` < updatedpackages.html

