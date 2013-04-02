package HashUri::FileHasher;

use strict;
use warnings;
use Utils;
use Digest::SHA qw(sha256);

our $VERSION = '0.01';

sub make_hash {
	my $file_name = $_[0];
	$file_name or die "No file name given";
	open(FILE, $file_name ) or die "Cannot read file";
	local $/;
	my $content = <FILE>;
	close (FILE);
	return "FA" . HashUri::Utils::get_base64(sha256($content));
}

1;

