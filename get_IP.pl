#!/usr/bin/perl -w 


open(IPNUM,"|ipconfig > ipdump") || die "Can't run 'ipconfig'...$!\n";
close(IPNUM);

# Open the dump file
open(IPNUM,"ipdump") || die "Can't open ipdump...$!\n";

# Parse out the lines with ip numbers
while ( <IPNUM> )  {
 chomp;
 if ( $_ =~ /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/) {
   push(@ipconf,split(/\D+/,$_));
 }
}

my $IPAdws2        = "$ipconf[1]." . "$ipconf[2]." . "$ipconf[3]." . "$ipconf[4]";
my $SubnetMsk2  = "$ipconf[6]." . "$ipconf[7]." . "$ipconf[8]." . "$ipconf[9]";
my $Router2          = "$ipconf[11]." . "$ipconf[12]." . "$ipconf[13]." . "$ipconf[14]";

print $IPAdws2;
print $SubnetMsk2;