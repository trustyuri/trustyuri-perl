package TrustyUri::Utils;

use strict;
use warnings;
use MIME::Base64 qw(encode_base64);

our $VERSION = '0.01';

sub get_trustyuri_tail {
	my $s = $_[0];
	if (!$s || $s !~ m/(.*[^A-Za-z0-9\-_]|)[A-Za-z0-9\-_]{25,}(\.[A-Za-z0-9\-_]{0,20})?/) {
		return "";
	}
	$s =~ s/^(.*[^A-Za-z0-9\-_]|)([A-Za-z0-9\-_]{25,})(\.[A-Za-z0-9\-_]{0,20})?$/$2/;
	return $s;
}

sub get_base64 {
	my $s = encode_base64($_[0]);
	$s =~ s/=//g;
	$s =~ s/\s//g;
	$s =~ s/\+/-/g;
	$s =~ s/\//_/g;
	return $s;
}

1;
