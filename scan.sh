#!/bin/bash

# Create the output file.
OUTPUT_FILE="wardrive-$(date +'%Y-%m-%d-%H:%M').log"
touch "$OUTPUT_FILE"

# Get GPS coordinates
gpsdata=$( gpspipe -w -n 10 |grep -m 1 lon )
lon=$( echo "$gpsdata" |jsawk 'return this.lon' )
lat=$( echo "$gpsdata" |jsawk 'return this.lat' )

# Get WiFi scan results from the first WiFi device
# ADD IN LON/LAT PAIR
# ADD IN THE WLAN IDENTIFIER
iw wlan0 scan |sed -e 's#(on wlan# (on wlan#g' |awk -f scan.awk >> "$OUTPUT_FILE"
iw wlan1 scan |sed -e 's#(on wlan# (on wlan#g' |awk -f scan.awk >> "$OUTPUT_FILE"
