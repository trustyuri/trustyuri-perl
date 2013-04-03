package HashUri::File::FileHasher;

use strict;
use warnings;
use HashUri::File::FileModule;
use HashUri::Utils;
use Digest::SHA qw(sha256);

no warnings 'redefine';

our $VERSION = '0.01';

sub make_hash {
	return HashUri::File::FileModule::algorithm_id() . HashUri::Utils::get_base64(sha256($_[0]));
}

1;
