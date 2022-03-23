#!/bin/bash

ls -1 *.tf | while read f ; do
  echo "Ciiphering $f"
  cat $f | gpg -e -r arnaud@mailops.fr -r arnaud.morin@gmail.com > $f.gpg
done
