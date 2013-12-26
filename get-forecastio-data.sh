#!/usr/bin/env bash

# set all required environment variables
. ./set-env-variables.sh

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
echo $jsonfile > $homedir/MOSTRECENT

