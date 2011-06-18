#! perl\bin\perl 
use strict;
use warnings;
use Win32::OLE qw(in);
$| = 1;

Win32::OLE->Option(Warn => 9);

my $locator = Win32::OLE->CreateObject('WbemScripting.SWbemLocator') or
warn;
my $service = $locator->ConnectServer('10.101.10.107', "root\\cimv2", ".\\Administrator", 'pifko89');

my @col = in($service->ExecQuery('Select * From Win32_Process'));

foreach my $proc(@col){
        print $proc->{Name}."\n";
}
