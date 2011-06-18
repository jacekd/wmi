 #!/usr/bin/perl -w
 use DBI;
 $dbh = DBI->connect('dbi:mysql:wmi:10.36.11.150','wmi','wmi') or die "Connection Error: $DBI::errstr\n";
 $sql = "select * from test";
 $sth = $dbh->prepare($sql);
 $sth->execute or die "SQL Error: $DBI::errstr\n";
 while ($row = $sth->fetchrow_array)
{
 print "$row \n";
} 