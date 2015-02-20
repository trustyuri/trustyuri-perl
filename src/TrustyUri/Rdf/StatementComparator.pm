package TrustyUri::Rdf::StatementComparator;

use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $hash = shift;
	my $self = {hash => $hash};
	bless $self, $class;
	return $self;
}

sub compare {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	my $c;
	$c = $self->compare_context($s1, $s2);
	if ($c != 0) { return $c; }
	$c = $self->compare_subject($s1, $s2);
	if ($c != 0) { return $c; }
	$c = $self->compare_predicate($s1, $s2);
	if ($c != 0) { return $c; }
	return $self->compare_object($s1, $s2);
}

sub compare_context {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	my $r1 = $s1->context();
	my $r2 = $s2->context();
	if ($r1->isa('RDF::Trine::Node::Nil') && $r2->isa('RDF::Trine::Node::Nil')) {
		return 0;
	}
	if ($r1->isa('RDF::Trine::Node::Nil')) {
		return -1;
	}
	if ($r2->isa('RDF::Trine::Node::Nil')) {
		return 1;
	}
	return $self->compare_uri($r1, $r2);
}

sub compare_subject {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	return $self->compare_uri($s1->subject(), $s2->subject());
}

sub compare_predicate {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	return $self->compare_uri($s1->predicate(), $s2->predicate());
}

sub compare_object {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	my $v1 = $s1->object();
	my $v2 = $s2->object();
	if ($v1->isa('RDF::Trine::Node::Literal') && !$v2->isa('RDF::Trine::Node::Literal')) {
		return 1;
	} elsif (!$v1->isa('RDF::Trine::Node::Literal') && $v2->isa('RDF::Trine::Node::Literal')) {
		return -1;
	} elsif ($v1->isa('RDF::Trine::Node::Literal')) {
		return $self->compare_literal($v1, $v2);
	} else {
		return $self->compare_uri($v1, $v2);
	}
}

sub compare_literal {
	my $self = shift;
	my $l1 = shift;
	my $l2 = shift;
	my $x1 = $l1->literal_value();
	my $x2 = $l2->literal_value();
	if ($x1 ne $x2) {
		return $x1 cmp $x2;
	}
	$x1 = $l1->literal_datatype();
	if (!$x1 && !($l1->literal_value_language())) {
		$x1 = 'http://www.w3.org/2001/XMLSchema#string';
	}
	$x2 = $l2->literal_datatype();
	if (!$x2 && !($l2->literal_value_language())) {
		$x2 = 'http://www.w3.org/2001/XMLSchema#string';
	}
	if (!$x1 && $x2) {
		return -1;
	} elsif ($x1 && !$x2) {
		return 1;
	} elsif ($x1 && $x1 ne $x2) {
		return $x1 cmp $x2;
	}
	$x1 = $l1->literal_value_language();
	$x2 = $l2->literal_value_language();
	if (!$x1 && $x2) {
		return -1;
	} elsif ($x1 && !$x2) {
		return 1;
	} elsif ($x1 && $x1 ne $x2) {
		return $x1 cmp $x2;
	}
	return 0;
}

sub compare_uri {
	my $self = shift;
	my $s1 = shift;
	my $s2 = shift;
	return $s1->uri_value() cmp $s2->uri_value();
}

1;
