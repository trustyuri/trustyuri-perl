package TrustyUri::Rdf::RdfModule;

use strict;
use warnings;
use TrustyUri::TrustyUriModule;
use TrustyUri::Rdf::RdfHasher;

no warnings 'redefine';

our @ISA = qw(TrustyUri::TrustyUriModule);
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
	my $h = TrustyUri::Rdf::RdfHasher::make_hash($resource);
	return ($hash eq $h);
}

1;
