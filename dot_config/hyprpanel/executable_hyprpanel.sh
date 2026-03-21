#! /usr/bin/env sh

killall -q hyprpanel && while pgrep -x hyprpanel >/dev/null; do sleep 0.1; done

/sbin/hyprpanel
