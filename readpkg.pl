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
  @fields=split(/\t/,$ipline);

  if (exists $config{$fields[0]})
{
  # if the package is not installed then don't bother checking it or storing details of it

  if (exists $latestp{$fields[0]})
  {
    $compare=system("dpkg --compare-versions ".$latestp{$fields[0]}." lt ".$fields[1]);
    if ($compare==0)
    {
      $latestp{$fields[0]}=$fields[1];
    }
  } else {
    $latestp{$fields[0]}=$fields[1];
  }
}

}

close A;

#open E,"> updatedpackages";
open H,"> updatedpackages.html";
open T,"< template.html";

$template=<T>;
$machine=`cat machine.txt`;

$ttitle="*title*";
$ptitle=index($template,$ttitle);

substr($template,$ptitle,length($ttitle))=$machine;


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
