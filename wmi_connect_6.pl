#! perl\bin\perl -w
use strict;
use Win32::OLE('in');

# supply a list of WMI classes to interrogate
my @requests = ('SoftwareLicensingService');

# supply a list of computer systems to query
my @computers = (".", "WMI02");

# Connect to each system's CimV2 repository in turn.
for my $computer( @computers ){
my $wmi_repos = Win32::OLE->GetObject("winmgmts:{impersonationLevel=impersonate}!\\\\$computer\\root\\CIMV2")
or die "WMI connection failed: ".Win32::OLE->LastError()."\n";

# Call to each desired Namespace in the current WMI repository.
for my $request( @requests ){
my $wmi_collection = $wmi_repos->ExecQuery("SELECT * FROM $request", "WQL", 48 )
or die "WQL query failed: ".Win32::OLE->LastError()."\n";

# For each member of the class, build a data-structure to hold its Methods and Properties.
for my $item (in $wmi_collection){
my @methods = join (", ", map {$_->{Name}}( in $item->{Methods_} ) );
my %properties = map { $_->{Name} => $_->{Value} }( in $item->{Properties_} );

# Then format and print the results.
print "\n$computer :: $request :: $properties{Name}\n", "\tMethods: @methods\n\tProperties:\n";
for my $property( sort keys %properties ){
( $properties{$property} )
? print "\t\t$property = $properties{$property}\n"
: print "\t\t$property =\n";
} } } }