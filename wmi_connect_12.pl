#!/usr/bin/perl
use strict;
use Win32::OLE('in');
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
my @computers = ("localhost", "WMI02", "WMI05");
foreach my $computer (@computers)
{
print "\n";
print "System Name : $computer \n";
my $oWMIService = Win32::OLE->GetObject( "winmgmts:\\\\$computer\\root\\CIMV2") or die "WMI connection failed.\n";
my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_ComputerSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems)
{
print "Name: 			$objItem->{Name}\n";
print "Caption: 		$objItem->{Caption}\n";
print "Domain: 			$objItem->{Domain}\n";
print "Manufacturer: 	$objItem->{Manufacturer}\n";
print "Model: 			$objItem->{Model}\n";
}

my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_OperatingSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems)
{
 print "Caption:       $objItem->{Caption}\n";
 print "BuildNum:      $objItem->{BuildNumber}\n";
 print "Build:         $objItem->{BuildType}\n";
 print "Version:       $objItem->{Version}\n";
 print "SerNum:        $objItem->{SerialNumber}\n";
 }


my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_LogicalDisk", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $disk (in $colItems) 
{
printf "%-7s %-25s %-8s %-5s\n $disk->{DeviceID} $disk->{Description} $disk->{FileSystem} $disk->{DriveType}";
print "\n";
}
my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_Product", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems)
{
print "Name: 		$objItem->{Name}\n";
print "Description:	$objItem->{Description}\n";
print "Vendor: 		$objItem->{Vendor}\n";
print "Version:		$objItem->{Version}\n";
print "InstallDate: $objItem->{InstallDate}\n";
print "InstallLocaltion:	$objItem->{InstallLocaltion}\n";
print "PackageCode: 	$objItem->{PackageCode}\n";
print "ProductId:	$objItem->{ProductID}\n";
print "RegCompany: 	$objItem->{RegCompany}\n";
print "RegOwner:	$objItem->{RegOwner}\n";
print "URLInfoAbout:	$objItem->{URLInfoAbout}\n";
}

}