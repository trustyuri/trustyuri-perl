package HashUri::Rdf::RdfHasher;

use strict;
use warnings;
use HashUri::Utils;
use HashUri::Rdf::RdfModule;
use HashUri::Rdf::StatementComparator;
use Digest::SHA qw(sha256);
use RDF::Trine::Parser;

no warnings 'redefine';

our $VERSION = '0.01';

sub make_hash {
	my $resource = shift;
	my $hash = $resource->get_hash();
	my $content = $resource->get_content();
	my $filename = $resource->get_filename();
	my $model = RDF::Trine::Model->new();
	my $err = "";
	eval { RDF::Trine::Parser->guess_parser_by_filename($filename)->parse_into_model("http://foo.org", $content, $model) };
	if ($@) {
		$err .= $@;
		die "No RDF parser succeeded:\n$err";
	}
	my $next = $model->as_stream();
	my @statements;
	while ( my $item = $next->() ) {
		push @statements, $item;
	}
	my $comparator = HashUri::Rdf::StatementComparator->new($hash);
	my @sorted = sort { $comparator->compare($a, $b) } @statements;
	my $s = "";
	foreach my $item(@sorted) {
		$s .= value_to_string($hash, $item->context());
		$s .= value_to_string($hash, $item->subject());
		$s .= value_to_string($hash, $item->predicate());
		$s .= value_to_string($hash, $item->object());
	}
	return HashUri::Rdf::RdfModule::algorithm_id() . HashUri::Utils::get_base64(sha256($s));
}

sub value_to_string {
	my $hash = shift;
	my $v = shift;
	if ($v->isa('RDF::Trine::Node::Blank')) {
		die "Unexpected blank node encountered";
	} elsif ($v->isa('RDF::Trine::Node::Resource')) {
		my $uri = $v->uri_value();
		$uri =~ s/$hash/ /g;
		return $uri . "\n";
	} elsif ($v->isa('RDF::Trine::Node::Literal')) {
		if ($v->has_datatype()) {
			return '^' . $v->literal_datatype() . " " . escape_string($v->literal_value()) . "\n";
		} elsif ($v->has_language()) {
			return '@' . $v->literal_value_language() . " " . escape_string($v->literal_value()) . "\n";
		} else {
			return '#' . escape_string($v->literal_value()) . "\n";
		}
	} elsif ($v->isa('RDF::Trine::Node::Nil')) {
		return "\n";
	} else {
		die "Unknown element";
	}
}

sub escape_string {
	my $s = shift;
	$s =~ s/\\/\\\\/g;
	$s =~ s/\n/\\n/g;
	return $s;
}

1;
