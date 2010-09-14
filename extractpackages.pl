#!/usr/bin/perl


my $file;

$file=$ARGV[0];

use warnings;
use strict;
use POSIX;
use DB_File;

my %packages;

tie %packages,'DB_File', $file.".db",O_CREAT|O_RDWR,0644;

undef %packages;

my $ipline;
my $want;
my %latestp;
my $foundversion;
my $foundpackage;
my $i;
my $compare;

while ($ipline=<STDIN>)
{
#  print $ipline;

  $want="Package";
  if (substr($ipline,0,length($want)) eq $want)
  {
    $foundpackage=substr($ipline,length($want)+2,-1);
  }

  $want="Version";
  if (substr($ipline,0,length($want)) eq $want)
  {
    $foundversion=substr($ipline,length($want)+2,-1);
#    print "Package [".$foundpackage."]\n";
#    print $want." [".$foundversion."]\n";
    if (exists $latestp{$foundpackage})
    {
      if ($latestp{$foundpackage} ne $foundversion)
      {
        $compare=system("dpkg --compare-versions ".$latestp{$foundpackage}." lt ".$foundversion);
        if ($compare==0)
        {
#          print "replacing ".$latestp{$foundpackage}." with ".$foundversion."\n";
          $latestp{$foundpackage}=$foundversion;
        }
      }
    } else {
        $latestp{$foundpackage}=$foundversion;
    }
  }

}

my $npackages=0;

foreach $i (keys %latestp)
{
  $packages{$i}=$latestp{$i};
  print $i.chr(9).$latestp{$i}.chr(9)."\n";
  $npackages+=1;
}
$packages{"num.packages"}=$npackages;

untie %packages;
