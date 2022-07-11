#!/bin/bash

prepend_zero () {
        seq -f "%02g" $1 $1
}

artist=$(echo -n $(cmus-remote -C status | grep "tag artist" | cut -c 12-))

if [[ $artist = *[!\ ]* ]]; then
        song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-))
        position=$(cmus-remote -C status | grep position | cut -c 10-)
        # minutes1=$(prepend_zero $(($position / 60)))
        # seconds1=$(prepend_zero $(($position % 60)))
        duration=$(cmus-remote -C status | grep duration | cut -c 10-)
        # minutes2=$(prepend_zero $(($duration / 60)))
        # seconds2=$(prepend_zero $(($duration % 60)))
        normalized=$(echo "scale=0; ($position * 100) / $duration" | bc)
        notify-send "Now Playing" "$artist - $song" --replace-id=1 -i /tmp/art/art.jpeg -h int:value:$normalized
else
        echo
fi