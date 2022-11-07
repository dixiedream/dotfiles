#!/bin/sh

isPaused=$(dunstctl is-paused)
stackTag=$DUNST_STACK_TAG

[ "$isPaused" = "false" ] && \
  [ "$stackTag" != "low-battery" ] && \
    paplay ~/.config/dunst/alert.wav
