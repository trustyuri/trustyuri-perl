package HashUri::File::FileModule;

use strict;
use warnings;
use HashUri::HashUriModule;
use HashUri::File::FileHasher;

no warnings 'redefine';

our @ISA = qw(HashUri::HashUriModule);
our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub algorithm_id { "FA" }

sub has_correct_hash {
	my $self = shift;
	my $resource = shift;
	my $hash = $resource->get_hash();
	my $h = HashUri::File::FileHasher::make_hash $resource->get_content();
	return ($hash eq $h);
}

1;
