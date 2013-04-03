package HashUri::File::ProcessFile;

use strict;
use warnings;
use HashUri::File::FileHasher;
use File::Copy qw(move);

our $VERSION = '0.01';

sub process {
	my $file_name = shift;
	$file_name or die "No file name given";
	open(IN, $file_name) or die "Cannot read file";
	local $/;
	my $content = <IN>;
	close (IN);
	my $hash = HashUri::File::FileHasher::make_hash $content;
	my $new_file_name = $file_name . "." . $hash;
	move $file_name, $new_file_name;
}

1;
