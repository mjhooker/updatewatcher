#!/usr/bin/perl


use strict;
use warnings;
use DB_File;
use POSIX;

my $ipline;
my @fields;
my $package;
my $version;
my %config;

open P,"< packages";
#open E,"> existingpackages";

my $ipackages=0;

while ($ipline=<P>)
{
#  print $ipline;
  chomp($ipline);
  @fields=split(/\t/,$ipline);

    $package=$fields[1];
    $version=$fields[2];

    $config{$package}{"version"}=$version;
    $ipackages+=1;
#    $config{$package}{"descr"}=$descr;

#    print E "Package: ".$package."\n";
#    print E "Version: ".$version."\n\n";
}

#close E;
close P;

my %readpkg;
my $i;
my $compare;
my %latestp;

# print "computing updates\n";
open A,"< allpackagefiles";

my $npackages=0;

while ($ipline=<A>)
{
  chomp ($ipline);
  tie (%readpkg, 'DB_File', $ipline.".db", O_RDONLY, 0);
  $npackages=$readpkg{"num.packages"};

'  print $ipackages.chr(9).$npackages.chr(9);
  if ($ipackages<$npackages)
  {
'    print "[".$ipackages."]\n";
    
    foreach $i (keys %config)
    {
      if (defined $readpkg{$i})
      {
        if (!exists $latestp{$i})
        {
          $latestp{$i}=$config{$i}{"version"};
        }
        $compare=system("dpkg --compare-versions ".$latestp{$i}." lt ".$readpkg{$i});
        if ($compare==0)
        {
          $latestp{$i}=$readpkg{$i};
        }
      }
    }
  } else {
'    print "[".$npackages."]\n";
    foreach $i (keys %readpkg)
    {

      if (exists $config{$i})
      {
        if (!exists $latestp{$i})
        {
          $latestp{$i}=$config{$i}{"version"};
        }
        $compare=system("dpkg --compare-versions ".$latestp{$i}." lt ".$readpkg{$i});
        if ($compare==0)
        {
          $latestp{$i}=$readpkg{$i};
        }
      }
    }
  }
  untie %readpkg;
}

close A;

#open E,"> updatedpackages";
open H,"> updatedpackages.html";
open T,"< template.html";

my $template=<T>;
my $machine=`cat machine.txt`;

my $ttitle="*title*";
my $ptitle=index($template,$ttitle);

substr($template,$ptitle,length($ttitle))=$machine;


print H $template;

$template=<T>;
# print H,$template;

my $tpackage="*Package*";
my $tcurrent="*Current*";
my $tnew="*New*";

foreach $i (sort (keys %config))
{
  if (exists $latestp{$i})
  {
    if ($latestp{$i} ne $config{$i}{"version"})
    {
#        print $i.chr(9).$config{$i}{"version"}." != ";
#        print $latestp{$i}."\n";

my $output=$template;
my $ppackage=index($template,$tpackage);
my $pnew=index($template,$tnew);
my $pcurrent=index($template,$tcurrent);



substr($output,$pnew,length($tnew))=$latestp{$i};
substr($output,$pcurrent,length($tcurrent))=$config{$i}{"version"};
substr($output,$ppackage,length($tpackage))=$i;

  print H $output;
#  print $output;
  
#    print E "Package: ".$i."\n";
#    print E "Version: ".$latestp{$i}."\n\n";

    }
  }
}

$template=<T>;
print H $template;


#close E;
close H;
close T;