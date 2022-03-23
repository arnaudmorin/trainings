#!/bin/bash

ls -1 *.gpg | while read f ; do
  echo "Unciphering $f"
  n=${f%.gpg}
  cat $f | gpg -d > $n
done
