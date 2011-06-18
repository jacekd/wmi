#!/usr/bin/perl -w 
# use strict;
use Win32::OLE('in');
use DBI;
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
$range = `C:\\Users\\Administrator\\wmi\\Nmap\\nmap -sP 10.36.11.0/24`;
$dbh = DBI->connect('dbi:mysql:wmi:10.36.11.150','wmi','wmi') or warn "Connection Error: $DBI::errstr\n";

my $warehouse = "BOAT1";
my @computers = ($range =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g);
foreach my $computer (@computers)
{
if (my $oWMIService = Win32::OLE->GetObject( "winmgmts:\\\\$computer\\root\\CIMV2")) { 
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
			

			
my $softwareItems = $oWMIService->ExecQuery ( "SELECT * FROM Win32_Product", "WQL", bFlagReturnImmediately | bFlagForwardOnly);
foreach my $objItem (in $softwareItems)
{ 
$sname = $objItem->{Name};
$description = $objItem->{Description};
$vendor = $objItem->{Vendor};
$version = $objItem->{Version};
$install_date = $objItem->{InstallDate};
$install_location = $objItem->{InstallLocation};
$package_code = $objItem->{PackageCode};
$product_id = $objItem->{ProductID};
$reg_company = $objItem->{RegCompany};
$reg_owner = $objItem->{RegOwner};
$url_info_about = $objItem->{URLInfoAbout};
$dbh->do("INSERT INTO software(warehouse,name,ip,sname,description,vendor,version,install_date,install_location,package_code,product_id,reg_company,reg_owner,url_info_about)
			VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
			undef,
			$warehouse, $name, $ip, $sname, $description, $vendor, $version, $install_date, $install_location, $package_code, $product_id, $reg_company, $reg_owner, $url_info_about);
}	

}
}
