#!/usr/bin/perl

$arch=`uname -m`;
chomp $arch;

if ($arch eq "i686")
{
 $arch="i386";
}


$hprefix="http://";

open R,"< /etc/apt/sources.list";

while ($ipline=<R>)
{
 chomp $ipline;
 if (substr($ipline,0,1) ne "#")
 {
  @fields=split(/ /,$ipline);
  if (substr($fields[1],0,length($hprefix)) eq $hprefix)
  {
   $fields[1]=substr($fields[1],length($hprefix))
  }

  for ($x=3;$x<10;$x++)
  {
   if (($fields[$x] gt "")&&($fields[0] eq "deb"))
   {
    print $fields[1]."dists/".$fields[2]."/".$fields[$x]."/binary-".$arch."/Packages\n"
   }
  }
#  print $ipline."\n";
 }
}

close R;

#deb http://archive.ubuntu.com/ubuntu/ jaunty main universe restricted multiverse
#deb http://security.ubuntu.com/ubuntu/ jaunty-security universe main multiverse restricted
#deb http://archive.ubuntu.com/ubuntu/ jaunty-updates universe main multiverse restricted


#archive.ubuntu.com/ubuntu/dists/jaunty/main/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty/multiverse/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty/universe/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty/restricted/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-security/main/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-security/multiverse/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-security/universe/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-security/restricted/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-updates/main/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-updates/multiverse/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-updates/universe/binary-i386/Packages
#archive.ubuntu.com/ubuntu/dists/jaunty-updates/restricted/binary-i386/Packages
