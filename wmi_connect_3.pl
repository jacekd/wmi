#!/usr/bin/perl
use strict;
use Win32::OLE;
use constant wbemFlagReturnImmediately => 0x10;
use constant wbemFlagForwardOnly => 0x20;
use constant WbemAuthenticationLevelPktPrivacy => 6;

my $computer = "10.101.10.107";
my $admin = ".\\jacek";
my $pwd = "pifko89";

my $wbem = Win32::OLE->new('WbemScripting.SWbemLocator');
my $objWMIService = $wbem->ConnectServer($computer,"",$admin,$pwd); 
$objWMIService->Security_->{authenticationLevel} = WbemAuthenticationLevelPktPrivacy;

my $colItems = $objWMIService->ExecQuery("SELECT * FROM Win32_OperatingSystem", "WQL", wbemFlagReturnImmediately | wbemFlagForwardOnly);


foreach my $objItem (in $colItems) {

      print "ServicePackMajorVersion: $objItem->{ServicePackMajorVersion}\n";

      print "ServicePackMinorVersion: $objItem->{ServicePackMinorVersion}\n";

      print "\n";

}