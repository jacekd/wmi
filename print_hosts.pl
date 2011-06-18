#!/usr/bin/perl
use warnings;


$range = `C:\\Users\\Administrator\\wmi\\Nmap\\nmap -sP 10.36.11.0/24`;
@ips = ($range =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g);
print join("\n", @ips);