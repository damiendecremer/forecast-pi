#!/usr/bin/bash

#place where data is stored
datadir=data
mkdir -p $datadir

# current time in filename
now=`date +%Y%m%d-%H%M`
jsonfile=$datadir/exeter-$now.json

# if file doesn't exist
if [ ! -e jsonfile ]
then
  # get exeter data from forecast.io and write to jsonfile
  wget "https://api.forecast.io/forecast/a5508a7280695c4b560b58f19a7c702c/50.7166,-3.5333" -O $jsonfile
fi

# update mostrecent file
echo $jsonfile > MOSTRECENT

