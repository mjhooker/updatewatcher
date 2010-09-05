#!/usr/bin/perl


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

foreach $i (keys %latestp)
{
  print $i.chr(9).$latestp{$i}.chr(9)."\n";
}
