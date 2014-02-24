package TrustyUri::TrustyUriResource;

use strict;
use warnings;

no warnings 'redefine';

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $filename = shift;
	my $content = shift;
	my $hash = shift;
	my $self = {'filename' => $filename, 'content' => $content, 'hash' => $hash};
	bless $self, $class;
	return $self;
}

sub get_filename {
	my $self = shift;
	return $$self{'filename'};
}

sub get_content {
	my $self = shift;
	return $$self{'content'};
}

sub get_hash {
	my $self = shift;
	return $$self{'hash'};
}

1;
