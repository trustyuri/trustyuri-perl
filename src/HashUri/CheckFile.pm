package HashUri::CheckFile;

use strict;
use warnings;
use HashUri::Utils;
use HashUri::ModuleDirectory;
use HashUri::File::FileHasher;
use LWP::Simple;

our $VERSION = '0.01';

sub check {
	my $file_name = shift;
	$file_name or die "No file name given";
	my $data_part = HashUri::Utils::get_hashuri_datapart($file_name);
	$data_part or die "No hash in file name";
	my $algorithm_id = substr($data_part, 0, 2);
	my $module = HashUri::ModuleDirectory::get_module $algorithm_id;
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
	if ($module->is_correct_hash($content, $data_part)) {
		print "Correct hash: " . $data_part . "\n";
	} else {
		print "*** INCORRECT HASH ***" . "\n";
	}
}

1;
