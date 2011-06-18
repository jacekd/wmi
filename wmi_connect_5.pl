#!/usr/bin/perl -w

# use bin\perl.exe wmi.pl to run.
# have fun!
# 2009/6/17 twitter.com/vinocui
# 
# useful links:
# (WMI space definition) http://msdn.microsoft.com/en-us/library/aa394084(VS.85).aspx
# (OLE usage on CPAN)    http://cpan.uwinnipeg.ca/htdocs/Win32-OLE/Win32/OLE.html#Object_methods_and_properties
#

use Win32::OLE;

#my $wmi = Win32::OLE->GetObject("winmgmts://./root/cimv2") or die "failed to retrieve cimv2.";
# winmgmts means to access WMI service.

my $wmi = Win32::OLE->GetObject("WinMgmts://./root/cimv2") or die "Failed: GetObject\n";
my $list, my $v;


$list = $wmi->InstancesOf("Win32_Processor") or die "Failed: InstancesOf\n";

foreach $v (Win32::OLE::in $list){
    print "CPU:\n";
    print "\t", $v->{Name}, "\n";
    print "\t", $v->{Caption}, "\n";
	}
	