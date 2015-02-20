( ls testsuite/RA/valid/* ;
) \
  | awk '{ print "echo \"Checking file: "$1"\"; scripts/CheckFile.sh "$1; }' \
  | bash
