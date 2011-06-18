#! perl\bin\perl -w
use Win32::OLE qw( in );
my $machine = "10.101.10.107";
my $WMIServices = Win32::OLE->GetObject ( "winmgmts:{impersonationLevel=impersonate,(security)}//$machine/root/cimv2" ) || die "cant call getobject";
my $HotFixCollection = $WMIServices->ExecQuery ( "select * from Win32_QuickFixEngineering" ) || die "Query Failed";

foreach my $hotfix ( in( $HotFixCollection )){
 $hotfixID = $hotfix->{HotFixID};
 print "Hotfix id is $hotfixID \n";
}
