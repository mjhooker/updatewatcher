#!/usr/bin/perl

require "repochecked.inc" or die ("Can't read repochecked.inc");

$file=$ARGV[0];

# print $file."\n";

if (exists $repo{$file})
{
#  print "found\n";
  exit 0;
} else {
  open R,">> repochecked.inc";
  print R "\$repo\{\"".$file."\"\}=\"Y\";\n";
  close R;
  exit 1;
}
