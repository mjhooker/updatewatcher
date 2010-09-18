#!/bin/bash


echo "#!/bin/bash" > siteinf.sh

MACH=`cat machine.inf`
ACC=`cat account.inf`
MGUID=`cat system.inf`
SITE=`cat site.inf`

echo MACH=${MACH} >> siteinf.sh
echo ACC=${ACC} >> siteinf.sh
echo MGUID=${MGUID} >> siteinf.sh
echo SITE=${SITE} >> siteinf.sh
echo ADDR=http://\$\{SITE\}/cgi-bin/ >> siteinf.sh
echo GUID=\\\?guid=\$\{MGUID\} >> siteinf.sh

