#!/bin/bash

# download raw file if it doesn't already exist
raw_file='https://zenodo.org/record/892005/files/qExactive01819.raw?download=1'
mkdir data-raw
wget -nc ${raw_file} -O raw/qExactive01819.raw

# convert raw file to mzML with ThermoRawFileParser
# don't use default vendor (i.e. Thermo) peak picking
docker run -v ${PWD}:/data/ quay.io/biocontainers/thermorawfileparser:1.2.3--1 ThermoRawFileParser \
-i /data/raw/qExactive01819.raw \
-o /data/raw/ -f 1 -p

# use OpenMS PeakPickerHiRes instead to convert data to centroided
# Note: depending on your mass spectrometer settings, raw data will be generated
# either in profile mode or centroid mode. 
# If your MS2 data are already centroided, simply omit the peak picking step.
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 PeakPickerHiRes \
-in /data/raw/qExactive01819.mzML \
-out /data/raw/qExactive01819_centroid.mzML
