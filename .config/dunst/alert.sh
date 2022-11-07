#!/bin/sh

[ "$(dunstctl is-paused)" = "false" ] && \
  [ "$DUNST_STACK_TAG" != "low-battery" ] && \
    paplay ~/.config/dunst/alert.wav
