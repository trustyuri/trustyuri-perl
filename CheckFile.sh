DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
perl -I$DIR -MCheckFile -e"HashUri::CheckFile::check(qw($*));"

