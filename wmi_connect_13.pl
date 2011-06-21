 #!/usr/bin/perl
 use Unix::Network qw(interfaces);
 my $interfaces = interfaces;
 foreach my $i (@$interfaces) {
     foreach (qw(ip netmask subnet)) {
         print "ip = $i->{$_}\n";
     }
     print "\n";
 }