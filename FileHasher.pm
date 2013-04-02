package HashUri::FileHasher;

use strict;
use warnings;
use Utils;
use Digest::SHA qw(sha256);

our $VERSION = '0.01';

sub make_hash {
	return "FA" . HashUri::Utils::get_base64(sha256($_[0]));
}

1;

