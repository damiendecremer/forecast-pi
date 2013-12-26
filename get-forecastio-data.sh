#!/usr/bin/env bash

forecast_id = `cat my-forecast-io-id.txt`

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
  wget "https://api.forecast.io/forecast/$forecast_id/50.7166,-3.5333" -O $jsonfile
fi

# update mostrecent file
echo $jsonfile > MOSTRECENT

