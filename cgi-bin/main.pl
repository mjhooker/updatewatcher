#!/usr/bin/perl

print "Content-type: text/html\r\n\r\n";

#print "QUERY_STRING\r\n";
$qs=$ENV{QUERY_STRING};

@values=split(/\?/,$qs);
@option=split(/\=/,$values[0]);

if ($option[0] eq "guid")
{
  $guid="";
  for ($x=0;$x<length($option[1]);$x++)
  {
    $c=substr($option[1],$x,1);
    if (($c ge "0")&&($c le "9")) {$guid.=$c;}
    if (($c ge "a")&&($c le "z")) {$guid.=$c;}
    if (($c ge "A")&&($c le "Z")) {$guid.=$c;}
    if ($c eq "-") {$guid.=$c;}
  }
}
    
#print $qs."\r\n";
#print $guid."\r\n";

if ($guid gt "")
{

print "<HTML><TITLE>\n";
print `cat ../httpdocs/config/$guid/machine.txt`;
print "</TITLE><style type=\"text/css\">#pkglist {font-family:\"Trebuchet MS\", Arial, Helvetica, sans-serif;width:100%;border-collapse:collapse;}#pkglist td, #pkglist th {font-size:1em;border:1px solid #98bf21;padding:3px 7px 2px 7px;}#pkglist th {font-size:1.1em;text-align:left;padding-top:5px;padding-bottom:4px;background-color:#A7C942;color:#ffffff;}#pkglist tr.alt td {color:#000000;background-color:#EAF2D3;}</style><table id=\"pkglist\"><tr><td>Header</td></tr><tr><td>\n";

print `cat ../httpdocs/config/$guid/repo.html`;

print "</tr><tr><td>\n";

print `cat ../httpdocs/config/$guid/updatable.html`;

print "</tr></table></html>";
}

#print "ENV\r\n";
#system "set";


