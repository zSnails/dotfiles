#!/bin/sh

pgrep dunst > /dev/null && killall dunst

dunst > /dev/null & disown
