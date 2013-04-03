DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
perl -I$DIR/src -MHashUri::File::ProcessFile -e"HashUri::File::ProcessFile::process(qw($*));"
