package HashUri::File::FileHasher;

use strict;
use warnings;
use HashUri::File::FileModule;
use HashUri::Utils;
use Digest::SHA qw(sha256);

no warnings 'redefine';

our $VERSION = '0.01';

sub make_hash {
	my $content = shift;
	return HashUri::File::FileModule::algorithm_id() . HashUri::Utils::get_base64(sha256($content));
}

1;
