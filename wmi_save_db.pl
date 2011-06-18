#!/usr/bin/perl -w 
# use strict;
use Win32::OLE('in');
use DBI;
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
$dbh = DBI->connect('dbi:mysql:wmi:10.36.11.150','wmi','wmi') or die "Connection Error: $DBI::errstr\n";

my $warehouse = "BOAT1";

my @computers = ("localhost", "WMI02");
foreach my $computer (@computers)
{
my $oWMIService = Win32::OLE->GetObject( "winmgmts:\\\\$computer\\root\\CIMV2") or die "WMI connection failed.\n";
my $colItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_ComputerSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $colItems) {
$name = $objItem->{Name};
$caption = $objItem->{Caption};
$domain = $objItem->{Domain};
$manufacturer = $objItem->{Manufacturer};
$model = $objItem->{Model};
$ip = $computer;
}

my $osItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_OperatingSystem", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $osItems)
{
$os_caption = $objItem->{Caption};
$os_buildnum = $objItem->{BuildNumber};
$os_build = $objItem->{BuildType};
$os_version = $objItem->{Version};
$os_serialnumber = $objItem->{SerialNumber};
}

my $diskItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_LogicalDisk", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $diskItems) 
{
$device_id = $objItem->{DeviceID};
$file_system = $objItem->{FileSystem};
$volume_serial_number = $objItem->{VolumeSerialNumber};
$size = $objItem->{Size};
$free_space = $objItem->{FreeSpace};
$dbh->do("INSERT INTO disks(warehouse,name,ip,device_id,file_system,serial_number,size,free_space) 
			VALUES (?,?,?,?,?,?,?,?)",
			undef,
			$warehouse, $name, $ip, $device_id, $file_system, $volume_serial_number, $size, $free_space);
}

$dbh->do("INSERT INTO equipment(warehouse,name,caption,domain,manufacturer,model,ip,os_caption,os_buildnum,os_build,os_version,os_serialnumber) 
			VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", 
			undef, 
			$warehouse, $name, $caption, $domain, $manufacturer, $model, $ip, $os_caption, $os_buildnum, $os_build, $os_version, $os_serialnumber);
			

}
