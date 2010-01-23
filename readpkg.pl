#!/usr/bin/perl

open P,"< packages";

while ($ipline=<P>)
{
#  print $ipline;
  chomp($ipline);
  if ($readpkg==1)
  {
    $state=unpack("A100",substr($ipline,$st{"state"},$ln{"state"})); #print "state: ".$state."\n";
    $package=unpack("A100",substr($ipline,$st{"package"},$ln{"package"})); #print "package: [".$package."]\n";
    $version=unpack("A100",substr($ipline,$st{"version"},$ln{"version"})); #print "version: [".$version."]\n";
    $descr=unpack("A100",substr($ipline,$st{"descr"},$ln{"descr"})); #print "descr: ".$descr."\n";

    $config{$package}{"state"}=$state;
    $config{$package}{"version"}=$version;
    $config{$package}{"descr"}=$descr;

  }
  if (substr($ipline,0,1) eq "+")
  {
    # got the format line
    @fields=split(/-/,$ipline);
    $ln{"state"}=length($fields[0])+1;
    $ln{"package"}=length($fields[1])+1;
    $ln{"version"}=length($fields[2])+1;
    $ln{"descr"}=length($fields[3])+1;

    $st{"state"}=0;
    $st{"package"}=$st{"state"}+$ln{"state"};
    $st{"version"}=$st{"package"}+$ln{"package"};
    $st{"descr"}=$st{"version"}+$ln{"version"};

    $readpkg=1;
  }
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
