#!/usr/bin/ruby

require 'net/http'
require 'uri'


pkgfile=File.open("packages")

readpkg=0


myconfig=Hash.new


while !pkgfile.eof do

ipline=pkgfile.readline

#puts ipline


  if ipline[0,1]=="+"
# got the format line

    st_state=0
    st_package=1+ipline.index("-",st_state+1)
    st_version=1+ipline.index("-",st_package+1)
    st_descr=1+ipline.index("-",st_version+1)

    len_state=st_package-st_state
    len_package=st_version-st_package
    len_version=st_descr-st_version
    len_descr=ipline.length-st_descr

#    puts "state",st_state,len_state
#    puts "package",st_package,len_package
#    puts "version",st_version,len_version
#    puts "descr",st_descr,len_descr


    readpkg=1
    ipline=pkgfile.readline
#    puts ipline
  end

  if readpkg==1

     c_state=ipline[st_state,len_state].rstrip
     c_package=ipline[st_package,len_package].rstrip
     c_version=ipline[st_version,len_version].rstrip
     c_descr=ipline[st_descr,len_descr].rstrip

#    $state=unpack("A100",substr($ipline,$st{"state"},$ln{"state"})); #print "state: ".$state."\n";
#    $package=unpack("A100",substr($ipline,$st{"package"},$ln{"package"})); #print "package: [".$package."]\n";
#    $version=unpack("A100",substr($ipline,$st{"version"},$ln{"version"})); #print "version: [".$version."]\n";
#    $descr=unpack("A100",substr($ipline,$st{"descr"},$ln{"descr"})); #print "descr: ".$descr."\n";

#    $config{$package}{"state"}=$state;
#    $config{$package}{"version"}=$version;
#    $config{$package}{"descr"}=$descr;


     myconfig[c_package]=[c_package,c_state,c_version,c_descr]


url = URI.parse('http://127.0.0.1:3000/packages.xml')
params = {
  'package[cid]' => 1,
  'package[package]' => c_package,
  'package[version]' => c_version,
  'package[state]' => c_state
}

resp = Net::HTTP.post_form(url, params)

resp_text = resp.body

puts resp_text

#     puts myconfig[c_package]

#	puts c_state
#        puts c_package,c_version,c_descr
#        puts c_package.length

  end

end

pkgfile.close


avail=Hash.new

#open A,"< allpackages";
pkgfile=File.open("allpackages")

while !pkgfile.eof do

ipline=pkgfile.readline

# puts ipline

#  print $ipline;

  if ipline[0,7]=="Package"
    foundpackage=ipline[9,ipline.length-10]
  end

  if ipline[0,7]=="Version"
    foundversion=ipline[9,ipline.length-10]
#    puts foundpackage
#    puts foundversion
    avail[foundpackage]=foundversion
#    puts avail[foundpackage]
  end

end

pkgfile.close


myconfig.each do |key| 
#  puts "key"
#  puts key[0]
#  puts "0"
#  puts key[1][0]
#  puts "1"
#  puts key[1][1]
#  puts "2"
#  puts key[1][2]
#  puts "3"
#  puts key[1][3]
#  puts "avail"
#  puts avail[key[0]]

 if avail[key[0]]!=key[1][2]
  puts key[0]
  puts "replace"
  puts key[1][2]
  puts "with"
  puts avail[key[0]]
 end
end




