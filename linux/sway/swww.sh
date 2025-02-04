#!/bin/bash
#
# start swww daemon and set initial wallpaper
#

# start if not already running
swww query &> /dev/null
if [ $? -ne 0 ] ; then
    swww-daemon --format xrgb &
fi


#background="/home/berts/Pictures/wallpapers/animated/waneella-city.gif"
#background="/home/berts/Pictures/wallpapers/wallhaven-5gqmg7.jpg"
#background="/home/berts/Pictures/wallpapers_ml4w/midnight-reflections-moonlit-sea.jpg"
background=0
if [ -n "$1" ]
then
    background=$1
else
    # set a default?
    background=$HOME/Pictures/wallpapers/wallhaven-2yxo29.png
    #echo "No wallpaper set."
    #exit 1
fi

echo "Calling swww for: $background"

# set wallpaper
xtrans="grow"
wallTransDuration=0.4
wallFramerate=60
#    --invert-y \
#    --transition-pos "$(hyprctl cursorpos)" \
swww img \
    "${background}" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type "${xtrans}" \
    --transition-duration "${wallTransDuration}" \
    --transition-fps "${wallFramerate}" &
