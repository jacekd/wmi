#!/usr/bin/perl
use strict;
use Win32::OLE('in');
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
#name space
	my $computer = "10.101.10.107";
    my $wmipath  = "root\\cimv2";
#domainname\username   
    my $user     = "jacek";
#password
   my $pwd      = "pifko89";

#New variable again to hold the instance of swbemlocator
 my $wmiwebloc = Win32::OLE->new('WbemScripting.SWbemLocator') || die "Cannot access WMI on local machine: ", Win32::OLE->LastError;

#old way of creating $wmi object
#no need of $class
   my $class = "WinMgmts://$computer";
   my $wmi = Win32::OLE->GetObject($class);

#new way which works for both the local and remote computer
#only host name is compulsary
 my $owmi = $wmiwebloc->ConnectServer($computer,$wmipath,$user,$pwd);
 my $colItems = $owmi->ExecQuery ( "SELECT * FROM Win32_ComputerSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems)
{
print "AdminPasswordStatus: $objItem->{AdminPasswordStatus}\n";
print "AutomaticResetBootOption: $objItem->{AutomaticResetBootOption}\n";
print "AutomaticResetCapability: $objItem->{AutomaticResetCapability}\n";
print "BootOptionOnLimit: $objItem->{BootOptionOnLimit}\n";
print "BootOptionOnWatchDog: $objItem->{BootOptionOnWatchDog}\n";
print "BootROMSupported: $objItem->{BootROMSupported}\n";
print "BootupState: $objItem->{BootupState}\n";
}