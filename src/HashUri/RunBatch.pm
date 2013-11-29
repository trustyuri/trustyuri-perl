package HashUri::RunBatch;

use strict;
use warnings;
use HashUri::CheckFile;
use HashUri::File::ProcessFile;
use LWP::Simple;
use Time::HiRes;

our $VERSION = '0.01';

sub run {
	my $file_name = shift;
	$file_name or die "No file name given";
	open my $file, $file_name or die "Could not open $file_name: $!";
	while (my $line = <$file>)  {
		$line =~ s/^\s+|\s+$//g;
		if ($line =~ /^#|^$/) {
			next;
		}
		print "COMMAND: $line\n";
		my @cmdargs  = split(' ', $line);
		my $cmd = shift @cmdargs;
		my $starttime = [Time::HiRes::gettimeofday()];
		eval {
			if ($cmd eq "CheckFile") {
				HashUri::CheckFile::check(@cmdargs);
			} elsif ($cmd eq "ProcessFile") {
				HashUri::File::ProcessFile::process(@cmdargs);
			} else {
				print "ERROR: Unrecognized command $cmd";
				exit 1;
			}
		} or do {
			my $m = $@;
			print "$m";
		};
		my $t = Time::HiRes::tv_interval($starttime);
		print "Time in seconds: $t\n";
		print "---\n";
	}
}

1;
