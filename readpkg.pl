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


# print "computing updates\n";
open A,"cat `cat allpackagefiles` |";

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

#open E,"> updatedpackages";
open H,"> updatedpackages.html";
open T,"< template.html";

$template=<T>;
print H $template;

$template=<T>;
# print H,$template;

$tpackage="*Package*";
$tcurrent="*Current*";
$tnew="*New*";

foreach $i (sort (keys %config))
{
  if (exists $latestp{$i})
  {
    if ($latestp{$i} ne $config{$i}{"version"})
    {
#        print $i.chr(9).$config{$i}{"version"}." != ";
#        print $latestp{$i}."\n";

$output=$template;
$ppackage=index($template,$tpackage);
$pnew=index($template,$tnew);
$pcurrent=index($template,$tcurrent);



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