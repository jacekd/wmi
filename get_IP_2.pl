#!/usr/bin/perl
$ipconfig = `ipconfig`;
@ips = ($ipconfig =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g);
$ip = $ips[0];
@ipsplit = split('\.', $ip);
$mask = $ips[1];
@masksplit = split('\.', $mask);
print "IP: $ip \n";
print "MASK: $mask \n";

print "MASK 3: $masksplit[2] \n";
print "IP 1,2: $ipsplit[0]\.$ipsplit[1] \n";

if ($masksplit[2] == 0) {
	print "$ipsplit[0]\.$ipsplit[1]\.0.0\/16";
} else {
	print "$ipsplit[0]\.$ipsplit[1]\.$ipsplit[2]\.0\/24";
}