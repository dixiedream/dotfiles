#!/bin/sh

[ "$(dunstctl is-paused)" = "false" ] && paplay ~/.config/dunst/alert.wav
