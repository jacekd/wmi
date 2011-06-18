#!/usr/bin/perl
use strict;
use Win32::OLE('in');
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
my @computers = ("localhost", "WMI02", "WMI03", "WMI04", "WMI05");
foreach my $computer (@computers)
{
print "\n";
print "—————————————————————–\n";
print "| System Name : $computer |\n";
print "—————————————————————–\n";
my $oWMIService = Win32::OLE->GetObject( "winmgmts:\\\\$computer\\root\\CIMV2") or die "WMI connection failed.\n";
my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_ComputerSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems)
{
print "AdminPasswordStatus: $objItem->{AdminPasswordStatus}\n";
print "AutomaticResetBootOption: $objItem->{AutomaticResetBootOption}\n";
print "AutomaticResetCapability: $objItem->{AutomaticResetCapability}\n";
print "BootOptionOnLimit: $objItem->{BootOptionOnLimit}\n";
print "BootOptionOnWatchDog: $objItem->{BootOptionOnWatchDog}\n";
print "BootROMSupported: $objItem->{BootROMSupported}\n";
print "BootupState: $objItem->{BootupState}\n";
print "Caption: $objItem->{Caption}\n";
print "ChassisBootupState: $objItem->{ChassisBootupState}\n";
print "CreationClassName: $objItem->{CreationClassName}\n";
print "CurrentTimeZone: $objItem->{CurrentTimeZone}\n";
print "DaylightInEffect: $objItem->{DaylightInEffect}\n";
print "Description: $objItem->{Description}\n";
print "Domain: $objItem->{Domain}\n";
print "DomainRole: $objItem->{DomainRole}\n";
print "EnableDaylightSavingsTime: $objItem->{EnableDaylightSavingsTime}\n";
print "FrontPanelResetStatus: $objItem->{FrontPanelResetStatus}\n";
print "InfraredSupported: $objItem->{InfraredSupported}\n";
print "InitialLoadInfo: " . join(",", (in $objItem->{InitialLoadInfo})) . "\n";
print "InstallDate: $objItem->{InstallDate}\n";
print "KeyboardPasswordStatus: $objItem->{KeyboardPasswordStatus}\n";
print "LastLoadInfo: $objItem->{LastLoadInfo}\n";
print "Manufacturer: $objItem->{Manufacturer}\n";
print "Model: $objItem->{Model}\n";
print "Name: $objItem->{Name}\n";
print "NameFormat: $objItem->{NameFormat}\n";
print "NetworkServerModeEnabled: $objItem->{NetworkServerModeEnabled}\n";
print "NumberOfProcessors: $objItem->{NumberOfProcessors}\n";
print "OEMLogoBitmap: " . join(",", (in $objItem->{OEMLogoBitmap})) . "\n";
print "OEMStringArray: " . join(",", (in $objItem->{OEMStringArray})) . "\n";
print "PartOfDomain: $objItem->{PartOfDomain}\n";
print "PauseAfterReset: $objItem->{PauseAfterReset}\n";
print "PowerManagementCapabilities: " . join(",", (in $objItem->{PowerManagementCapabilities})) . "\n";
print "PowerManagementSupported: $objItem->{PowerManagementSupported}\n";
print "PowerOnPasswordStatus: $objItem->{PowerOnPasswordStatus}\n";
print "PowerState: $objItem->{PowerState}\n";
print "PowerSupplyState: $objItem->{PowerSupplyState}\n";
print "PrimaryOwnerContact: $objItem->{PrimaryOwnerContact}\n";
print "PrimaryOwnerName: $objItem->{PrimaryOwnerName}\n";
print "ResetCapability: $objItem->{ResetCapability}\n";
print "ResetCount: $objItem->{ResetCount}\n";
print "ResetLimit: $objItem->{ResetLimit}\n";
print "Roles: " . join(",", (in $objItem->{Roles})) . "\n";
print "Status: $objItem->{Status}\n";
print "SupportContactDescription: " . join(",", (in $objItem->{SupportContactDescription})) . "\n";
print "SystemStartupDelay: $objItem->{SystemStartupDelay}\n";
print "SystemStartupOptions: " . join(",", (in $objItem->{SystemStartupOptions})) . "\n";
print "SystemStartupSetting: $objItem->{SystemStartupSetting}\n";
print "SystemType: $objItem->{SystemType}\n";
print "ThermalState: $objItem->{ThermalState}\n";
print "TotalPhysicalMemory: $objItem->{TotalPhysicalMemory}\n";
print "UserName: $objItem->{UserName}\n";
print "WakeUpType: $objItem->{WakeUpType}\n";
print "Workgroup: $objItem->{Workgroup}\n";
print "\n";
}
}