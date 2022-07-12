#!/bin/bash

artist=$(echo -n $(playerctl --player=spotify metadata | grep "xesam:artist" | cut -c 34-))

if [[ $artist = *[!\ ]* ]]; then
        song=$(echo -n $(playerctl --player=spotify metadata | grep "xesam:title" | cut -c 35-))
        echo -n "$artist - $song"
else
        echo
fi
