#!/bin/bash

RTAIL=./rtail
HOST=localhost
FILE=`pwd`/test.txt

expected=`cat $FILE`
out=`$RTAIL $HOST $FILE`

if [[ "$expected" != "$out" ]]; then
  echo "fail"
  exit 1
fi

echo "pass"
exit 0
