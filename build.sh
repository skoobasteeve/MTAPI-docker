#!/usr/bin/env bash

MTAPI_URL="https://github.com/jonthornton/MTAPI.git"
SUBWAY_DATA_URL="http://web.mta.info/developers/data/nyct/subway/google_transit.zip"

# Create tmp directory
if [ -d "tmp" ]; then
    rm -rf "tmp"
    mkdir tmp
else
    mkdir tmp
fi

# Clone the MTAPI repo
if [ -d "tmp/MTAPI" ]; then
    rm -rf "tmp/MTAPI"
    git clone "$MTAPI_URL" tmp/MTAPI
else
    git clone "$MTAPI_URL" tmp/MTAPI
fi

# Download and extract subway data from MTA
curl -o tmp/subway.zip "$SUBWAY_DATA_URL"
unzip -d tmp/subway-data -o tmp/subway.zip

# Create the stations data files
echo "stations csv"
python tmp/MTAPI/scripts/make_stations_csv.py tmp/subway-data/stops.txt tmp/subway-data/transfers.txt > data/stations.csv
echo "stations json"
python tmp/MTAPI/scripts/make_stations_json.py data/stations.csv > data/stations.json
echo "done"

# Build the container
podman build .

