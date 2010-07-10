#!/bin/bash

# dpkg-query -l | grep -v "^rc" > packages
# echo checking installed packages

rm packages
touch packages

GET http://$1/config/$2/packages.txt > packages

