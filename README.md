# Bash Wardriving Proof of Concept

## The big idea
There are two ideas here. The first idea is that wardriving programs like Kismet are really complicated, and I’d prefer something a lot simpler. The second is that wardriving in stereo (two antennas) can provider better location of the base station, by combining the data from both antennas, but existing wardriving software does not appear to do that.

## How it should work

- Every X seconds, the following things are done:
  - both of the WiFi receivers are queried for available base stations and the germane details about each
  - the current coordinates are retrieved from gpsd
  - all of this data is appended to a text file, including a timestamp and, for each identified base station, an identifier for which of the two WiFi receivers that the data came from
- A post-processor does the following things:
  - identifies the strongest pair of data points for each BSSID
  - identifies the direction of travel for each data point (using the prior and subsequent data points)
  - uses each BSSID's pair of data points to identify the direction that it was in
  - uses the signal strength to estimate the distance of the base station (no idea if this will work)
  - assign coordinates to the base station
  - emits a CSV file of all identified base stations, including SSID, BSSID, timestamp, coordinates, and possibly a few other fields
