package TrustyUri::ModuleDirectory;

use strict;
use warnings;
use TrustyUri::File::FileModule;
use TrustyUri::Rdf::RdfModule;

our $VERSION = '0.01';

my %modules = ();

add_module(TrustyUri::File::FileModule->new());
add_module(TrustyUri::Rdf::RdfModule->new());

sub add_module {
	my $m = shift;
	$modules{$m->module_id} = $m;
}

sub get_module {
	my $id = shift;
	return $modules{$id};
}

1;
