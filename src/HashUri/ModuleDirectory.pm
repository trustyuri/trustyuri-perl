package HashUri::ModuleDirectory;

use strict;
use warnings;
use HashUri::File::FileModule;
use HashUri::Rdf::RdfModule;

our $VERSION = '0.01';

my %modules = ();

add_module(HashUri::File::FileModule->new());
add_module(HashUri::Rdf::RdfModule->new());

sub add_module {
	my $m = shift;
	$modules{$m->algorithm_id} = $m;
}

sub get_module {
	my $id = shift;
	return $modules{$id};
}

1;
