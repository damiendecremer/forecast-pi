#!/usr/bin/env bash

. ./set-env-variables.sh

$homedir/get-forecastio-data.sh
/usr/bin/env Rscript -e "home.dir <- '$homedir'; source('$homedir/draw-precip-onehour.R')"
$homedir/publish-txt.sh

