#!/usr/bin/env bash

. ./set-env-variables.sh

# get MOSTRECENT figure file
file=`grep ^$figdir/.*precip-onehour.txt$ $homedir/MOSTRECENT`
cp -f $file $pubdir/exeter-precip-onehour.txt

# commit and push change to github
cd $homedir
git add $pubdir/exeter-precip-onehour.txt
git commit -m "precip one hour `date +%Y%m%d-%H%M`"
git push origin master

