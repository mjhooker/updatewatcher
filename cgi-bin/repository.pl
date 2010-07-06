#!/usr/bin/perl

print "Content-type: text/html\r\n\r\n";
print "<HTML><PRE>";

#print "QUERY_STRING\r\n";
$qs=$ENV{QUERY_STRING};

@values=split(/\?/,$qs);
@option=split(/\=/,$values[0]);

if ($option[0] eq "guid")
{
  $guid="";
  for ($x=0;$x<length($option[1]);$x++)
  {
    $c=substr($option[1],$x,1);
    if (($c ge "0")&&($c le "9")) {$guid.=$c;}
    if (($c ge "a")&&($c le "z")) {$guid.=$c;}
    if (($c ge "A")&&($c le "Z")) {$guid.=$c;}
    if ($c eq "-") {$guid.=$c;}
  }
}
    
#print $qs."\r\n";
#print $guid."\r\n";

if ($guid gt "")
{
  system "mkdir ../httpdocs/config/".$guid;
  open C,"> ../httpdocs/config/".$guid."/repository.txt";
  while ($ipline=<STDIN>)
{
#  print $ipline;
  print C $ipline;
}
}
close C;

#print "ENV\r\n";
#system "set";


print "</PRE></HTML>";

