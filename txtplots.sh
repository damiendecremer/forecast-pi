#!/usr/bin/env bash

# set home directory conditional on hostname
if [ `hostname` = horstkevin ]; then
  homedir=/home/stefan/folders/forecast-pi-git
fi
if [ `hostname` = raspberrypi ]; then
  homedir=/home/pi/folders/forecast-pi
fi

#init directories
datadir=$homedir/data
figdir=$homedir/fig
pubdir=$homedir/pub
Rdir=$homedir/R
mkdir -p $datadir 
mkdir -p $figdir 
mkdir -p $pubdir
mkdir -p $Rdir

# get forecast.io id
forecast_id=`cat $homedir/my-forecast-io-id.txt`

# initialize files
tmpfile_precip=/tmp/exeterprecip.tmp
tmpplotfile_precip=/tmp/exeterprecip_plot.tmp
pubfile_precip=$pubdir/exeter-precip-onehour.txt


# download data from forecast.io
# current time in filename
now=`date +%Y%m%d-%H%M`
jsonfile=$datadir/exeter-$now.json
if [ ! -e jsonfile ]
then
  wget "https://api.forecast.io/forecast/$forecast_id/50.7166,-3.5333" -O $jsonfile
fi
echo $jsonfile > $tmpfile_precip

# run R programs to generate plots
/usr/bin/env Rscript $Rdir/draw-precip-onehour.R
cp -f $tmpplotfile_precip $pubdir/exeter-precip-onehour.txt

# commit changes and push to github
cd $homedir
git add $pubfile_precip
git commit -m "precip one hour `date +%Y%m%d-%H%M`"
git push origin master

#clean up
rm $tmpfile_precip
rm $tmpplotfile_precip
