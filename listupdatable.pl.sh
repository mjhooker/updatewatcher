#!/bin/bash

./makelinks.sh
./getpackages.sh
./readpkg.pl
POST http://localhost/cgi-bin/updateable.pl?guid=`cat system.inf` < updatedpackages.html

