package HashUri::CheckFile;

use strict;
use warnings;
use Utils;
use FileHasher;

our $VERSION = '0.01';

sub check {
	my $file_name = $_[0];
	$file_name or die "No file name given";
	my $data_part = HashUri::Utils::get_hashuri_datapart($file_name);
	$data_part or die "No hash in file name";
	if ($data_part !~ m/^FA/) {
		die "Unknown algorithm";
	}
	my $hash = HashUri::FileHasher::make_hash $file_name;
	if ($data_part eq $hash) {
		print "Correct hash: " . $hash . "\n";
	} else {
		print "*** INCORRECT HASH ***" . "\n";
	}
}

1;

