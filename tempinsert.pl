
sub tempinsert {
  my ($s,$f,$r)=@_;
  my $p,$l;
  
  $p=index($s,"*".lc($f)."*");
  if ($p>-1)
  {
    $l=2+length($f);
    substr($s,$p,$l)=$r;
    return $s;
  }
  return $s;
}


1;
