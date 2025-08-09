#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do slepp 1; done
polybar left &
polybar center &
polybar right &