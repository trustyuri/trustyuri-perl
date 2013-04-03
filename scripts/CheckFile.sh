DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
perl -I$DIR/src -MHashUri::CheckFile -e"HashUri::CheckFile::check(qw($*));"
