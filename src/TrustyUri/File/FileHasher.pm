package TrustyUri::File::FileHasher;

use strict;
use warnings;
use TrustyUri::File::FileModule;
use TrustyUri::Utils;
use Digest::SHA qw(sha256);

no warnings 'redefine';

our $VERSION = '0.01';

sub make_hash {
	my $content = shift;
	return TrustyUri::File::FileModule::module_id() . TrustyUri::Utils::get_base64(sha256($content));
}

1;
