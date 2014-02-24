package TrustyUri::CheckFile;

use strict;
use warnings;
use TrustyUri::Utils;
use TrustyUri::ModuleDirectory;
use TrustyUri::TrustyUriResource;
use TrustyUri::File::FileHasher;
use LWP::Simple;

our $VERSION = '0.01';

sub check {
	my $file_name = shift;
	$file_name or die "No file name given";
	my $tail = TrustyUri::Utils::get_trustyuri_tail($file_name);
	$tail or die "No hash in file name";
	my $algorithm_id = substr($tail, 0, 2);
	my $module = TrustyUri::ModuleDirectory::get_module $algorithm_id;
	if (!$module) {
		die "Unknown algorithm";
	}
	my $content = get($file_name);
	if (!$content) {
		open(IN, $file_name) or die "Cannot read file";
		local $/;
		$content = <IN>;
		close (IN);
	}
	my $resource = TrustyUri::TrustyUriResource->new($file_name, $content, $tail);
	if ($module->has_correct_hash($resource)) {
		print "Correct hash: " . $tail . "\n";
	} else {
		print "*** INCORRECT HASH ***\n";
	}
}

1;
