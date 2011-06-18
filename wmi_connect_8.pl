#! perl\bin\perl -w
use strict;
use warnings;
use Win32::OLE qw[in];

my $host = $ARGV[0] || '.';
my $wmi = Win32::OLE->GetObject( "winmgmts://$host/root/cimv2" )
or die Win32::FormatMessage( Win32::OLE::LastError() );

my %instances = (
Win32_PhysicalMemory => \&get_pmem,
Win32_PerfRawData_PerfOS_Memory => \&get_amem,
);

my $out;
foreach ( keys %instances ) {
my $class = $wmi->InstancesOf( $_ );
$out .= $instances{ $_ }->( $class );
}
print $out;

sub get_pmem {
my $class = shift;
my $total;
$total += $_->{Capacity} foreach in($class);
return "Physical Memory: $total\n";
}

sub get_amem {
my $class = shift;
my $amem;
$amem .= join ' ', $_->{AvailableBytes} foreach in($class);
return "Available Memory: $amem\n";
}