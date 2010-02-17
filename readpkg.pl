#!/usr/bin/perl

open P,"< packages";

while ($ipline=<P>)
{
#  print $ipline;
  chomp($ipline);
  @fields=split(/\t/,$ipline);

    $package=$fields[1];
    $version=$fields[2];

    $config{$package}{"version"}=$version;
    $config{$package}{"descr"}=$descr;

}

close P;

open A,"< allpackages";

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
    $latestp{$foundpackage}=$foundversion;
  }


}

close A;

foreach $i (keys %config)
{
  if (exists $latestp{$i})
  {
    if ($latestp{$i} ne $config{$i}{"version"})
    {
        print $i.chr(9).$config{$i}{"version"}." -> ";
        print $latestp{$i}."\n";
    }
  }
}
