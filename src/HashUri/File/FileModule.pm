package HashUri::File::FileModule;

use strict;
use warnings;
use HashUri::HashUriModule;
use HashUri::File::FileHasher;

no warnings 'redefine';

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub algorithm_id { "FA" }

sub is_correct_hash {
	my $self = shift;
	my $content = shift;
	my $hash = shift;
	my $h = HashUri::File::FileHasher::make_hash $content;
	return ($hash eq $h);
}

1;
