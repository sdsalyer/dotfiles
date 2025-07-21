#!/bin/bash
#
# set power profile using dmenu
#

current_profile=$(asusctl profile --profile-get | tail -n +2 | cut -d' ' -f 4)
profile_arr=$(asusctl profile --list| tail -n +2)

readarray -t my_array <<<"$profile_arr"
found=
for index in "${!my_array[@]}"; do
    #echo "$index ${my_array[index]}"
    [ ${my_array[index]} == $current_profile ] && found=$index
done

#echo "found: $found"
[[ ! -z found ]] && unset my_array[found]
#echo ${my_array[@]}

#list=$(IFS=$'\n'; echo "${my_array[*]}")
list=$(printf '%s\n' ${my_array[@]})
selected_profile=$(echo "$list" | wofi -d -p "Current: $current_profile")

#echo "$selected_profile"
if [[ -n "$selected_profile" ]]; then 
    asusctl profile --profile-set "$selected_profile";
fi
