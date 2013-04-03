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

sub is_correct_hash {
	my $self = shift;
	my $content = shift;
	my $hash = shift;
	my $h = HashUri::Rdf::RdfHasher::make_hash($hash, $content);
	return ($hash eq $h);
}

1;
