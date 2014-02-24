#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../src && pwd )"
perl -I$DIR -M"TrustyUri::File::ProcessFile" -e"TrustyUri::File::ProcessFile::process(qw($*));"
