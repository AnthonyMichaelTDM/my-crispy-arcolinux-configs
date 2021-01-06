#!/bin/sh
sed -i \
         -e 's/#3d3d3d/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeee/rgb(100%,100%,100%)/g' \
    -e 's/#272826/rgb(50%,0%,0%)/g' \
     -e 's/#db2d20/rgb(0%,50%,0%)/g' \
     -e 's/#2c2d2b/rgb(50%,0%,50%)/g' \
     -e 's/#dddddd/rgb(0%,0%,50%)/g' \
	"$@"
