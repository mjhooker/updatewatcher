#!/usr/bin/perl

$chars="abcdefghijklmnopqrstuvwxyz";
$numbers="01234567890";
$others="-";

$validcomp=$chars.uc($chars).$numbers.$others;

sub iscomp
{
  my ($s)=@_;
  my $p;
  my $c;

#  print "checking $s\n";
  
  if (length($s)==0)
  {
#    print "invalid";
    return 0;
  }
  for ($p=0;$p<length($s);$p++)
  {
    $c=substr($s,$p,1);
    if (index($validcomp,$c)==-1)
    {
#      print "invalid";
      return 0;
    }
  }
  return 1;
}

sub issite
{
  my ($s)=@_;
  my @q;
  my $x;
  
#  print "checking site $s\n";
  @q=split(/\./,$s);
#  print (@q+0)."\n";
  if (@q<1)
  {
#    print "invalid";
    return 0;
  }
  for ($x=0;$x<(@q+0);$x++)
  {
    if (!iscomp($q[$x]))
    {
#      print "invalid";
      return 0;
    }
  }
  return 1;
}


while ($ipline=<STDIN>)
{
  chomp($ipline);
  $linevalid=1;
  print $ipline."\n";
  @fields=split(/\//,$ipline);
  $nfields=@fields;
  for ($x=0;$x<$nfields;$x++)
  {
#    print $x.chr(9).$fields[$x]."\n";
    if ($x==0)
    {
      if (!issite($fields[$x]))
      {
        $linevalid=0;
      }
    }
    if (($x>0)&&($x<($nfields-1)))
    {
      if (!iscomp($fields[$x]))
      {
        $linevalid=0;
      }
    }
    if ($x==$nfields)
    {
      if ($fields[$x] ne "Packages")
      {
        $linevalid=0;
      }
    }
  }
  if ($linevalid)
  {
    print "valid\n";
    # arch dist section
    $repo{$fields[$nfields-1]}{$fields[$nfields-3]}{$fields[$nfields-2]}=$ipline;
  } else {
    print "invalid\n";
  }
}

foreach $arch (keys %repo)
{
  foreach $dist (keys %repo{$arch})
  {
    foreach $section (keys %repo{$arch}{$dist})
    {
      print $arch.chr(9).$dist.chr(9).$section."\n";
    }
  }
}