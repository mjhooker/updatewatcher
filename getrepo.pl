#!/usr/bin/perl

$arch=`uname -m`;
chomp $arch;

if ($arch eq "i686")
{
 $arch="i386";
}
if ($arch eq "x86_64")
{
 $arch="amd64";
}
if ($arch eq "ppc")
{
 $arch="powerpc";
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
    $dists="dists/";
    if (substr($fields[1],-1,1) ne "/")
    {
     $dists="/".$dists;
    }
    print $fields[1].$dists.$fields[2]."/".$fields[$x]."/binary-".$arch."/Packages\n"
   }
  }
#  print $ipline."\n";
 }
}

close R;

