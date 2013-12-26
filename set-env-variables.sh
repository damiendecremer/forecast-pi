#!/usr/bin/env bash

if [ `hostname` = horstkevin ]; then
  homedir=/home/stefan/folders/forecast-pi-git
fi
if [ `hostname` = raspberrypi ]; then
  homedir=/home/pi/forecast-pi
fi

datadir=$homedir/data
figdir=$homedir/fig
pubdir=$homedir/pub
mkdir -p $datadir 
mkdir -p $figdir 
mkdir -p $pubdir

forecast_id=`cat my-forecast-io-id.txt`

