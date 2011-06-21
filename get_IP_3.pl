#!/usr/bin/perl -w 
# use strict;
use Win32::OLE('in');
use DBI;
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
$ipconfig = `ipconfig`;
@ips = ($ipconfig =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g);
$ip = $ips[0];
@ipsplit = split('\.', $ip);
$mask = $ips[1];
@masksplit = split('\.', $mask);
if ($masksplit[2] == 1) {
	$range = "$ipsplit[0]\.$ipsplit[1]\.0.0\/16";
} else {
	$range = "$ipsplit[0]\.$ipsplit[1]\.$ipsplit[2]\.0\/24";
}
$rangeScan = `C:\\Users\\Administrator\\wmi\\Nmap\\nmap -sP $range`;
$dbh = DBI->connect('dbi:mysql:wmi:10.36.11.150','wmi','wmi') or warn "Connection Error: $DBI::errstr\n";

my $warehouse = "WAREHOUSE_03";
my @computers = ($rangeScan =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g);
foreach my $computer (@computers)
{
print "$computer \n";
}
