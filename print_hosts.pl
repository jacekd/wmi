#!/usr/bin/perl
use strict;
use Win32::OLE('in');
use constant bFlagReturnImmediately => 0x10;
use constant bFlagForwardOnly => 0x20;
my $oWMIService = Win32::OLE->GetObject( "winmgmts:\\\\.\\root\\CIMV2") or die "WMI connection failed.\n";