echo "----------------------------------"
echo "The tests below should all SUCCEED"
echo "----------------------------------"
echo

ls testsuite/RA/valid/* \
  | awk '{ print "echo \"Checking file: "$1"\"; scripts/CheckFile.sh "$1; }' \
  | bash

echo
echo "-------------------------------"
echo "The tests below should all FAIL"
echo "-------------------------------"
echo

ls testsuite/RA/invalid/* \
  | awk '{ print "echo \"Checking file: "$1"\"; scripts/CheckFile.sh "$1; }' \
  | bash
