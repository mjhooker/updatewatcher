#!/usr/bin/perl

open P,"< packages";
#open E,"> existingpackages";

while ($ipline=<P>)
{
#  print $ipline;
  chomp($ipline);
  @fields=split(/\t/,$ipline);

    $package=$fields[1];
    $version=$fields[2];

    $config{$package}{"version"}=$version;
    $config{$package}{"descr"}=$descr;

#    print E "Package: ".$package."\n";
#    print E "Version: ".$version."\n\n";
}

#close E;
close P;


print "computing updates\n";
open A,"cat `cat newpackagefiles` |";

while ($ipline=<A>)
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

close A;

open E,"> updatedpackages";


foreach $i (keys %config)
{
  if (exists $latestp{$i})
  {
    if ($latestp{$i} ne $config{$i}{"version"})
    {
        print $i.chr(9).$config{$i}{"version"}." != ";
        print $latestp{$i}."\n";
    print E "Package: ".$i."\n";
    print E "Version: ".$latestp{$i}."\n\n";

    }
  }
}

close E;
