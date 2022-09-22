#! /bin/bash
set -eux

touch radar.db
mv radar.db radar.bak.db
touch radar.db

# Simple example
sqlite-utils insert radar.db radar radar-data.json

# Example with lookup tables for named rings and quadrants
sqlite-utils insert radar.db radar-named-lut radar-data.json
sqlite-utils insert radar.db rings rings.json
sqlite-utils extract radar.db radar-named-lut ring --fk-column "ring" --rename ring id --table rings
sqlite-utils insert radar.db quadrants quadrants.json
sqlite-utils extract radar.db radar-named-lut quadrant --fk-column "quadrant" --rename quadrant id --table quadrants

# Example with only required fields
sqlite-utils insert radar.db radar-minimal radar-data-minimal.json

# Counter example. Should not show the radar.
sqlite-utils insert radar.db not-a-radar other-data.json
