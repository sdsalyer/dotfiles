#! /bin/bash
#
# start swww daemon and set initial wallpaper
#

# start if not already running
swww query &> /dev/null
if [ $? -ne 0 ] ; then
    swww-daemon --format xrgb &
fi


# set initial wallpaper
#background="/home/berts/Pictures/wallpapers/animated/waneella-city.gif"
#background="/home/berts/Pictures/wallpapers/wallhaven-5gqmg7.jpg"
background="/home/berts/Pictures/wallpapers_ml4w/midnight-reflections-moonlit-sea.jpg"
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
