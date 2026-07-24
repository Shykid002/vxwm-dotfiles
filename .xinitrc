#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile

exec vxwm >/dev/null 2>&1
