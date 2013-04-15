#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../src && pwd )"
perl -I$DIR -M"HashUri::File::ProcessFile" -e"HashUri::File::ProcessFile::process(qw($*));"
