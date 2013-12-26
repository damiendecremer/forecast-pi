#!/usr/bin/env bash

# get MOSTRECENT figure file
file=`grep ^fig.*precip-onehour.txt$ MOSTRECENT`
cp -f $file pub/exeter-precip-onehour.txt

# commit and push change to github
git add pub/exeter-precip-onehour.txt
git commit -m "precip one hour `date +%Y%m%d-%H%M`"
git push origin master


