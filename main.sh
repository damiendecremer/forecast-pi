#!/usr/bin/env bash
./get-forecastio-data.sh
Rscript draw-precip-onehour.R
./publish-txt.sh

