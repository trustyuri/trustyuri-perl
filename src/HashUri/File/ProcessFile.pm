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
	my $ext = "";
	my $base = $file_name;
	if ($file_name =~ /.\.[A-Za-z0-9\-_]{0,20}$/) {
		$ext = $file_name;
		$ext =~ s/^(.*)(\.[A-Za-z0-9\-_]{0,20})$/$2/;
		$base =~ s/^(.*)(\.[A-Za-z0-9\-_]{0,20})$/$1/;
	}
	my $new_file_name = $base . "." . $hash . $ext;
	move $file_name, $new_file_name;
}

1;
