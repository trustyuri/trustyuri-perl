package HashUri::Rdf::RdfModule;

use strict;
use warnings;
use HashUri::HashUriModule;
use HashUri::Rdf::RdfHasher;

no warnings 'redefine';

our @ISA = qw(HashUri::HashUriModule);
our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub algorithm_id { "RA" }

sub has_correct_hash {
	my $self = shift;
	my $resource = shift;
	my $hash = $resource->get_hash();
	my $h = HashUri::Rdf::RdfHasher::make_hash($resource);
	return ($hash eq $h);
}

1;
