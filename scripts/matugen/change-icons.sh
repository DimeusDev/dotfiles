#!/usr/bin/env bash
# maps matugen color to nearest Colloid-Dark icon variant via HSV hue

COLOR_FILE="$HOME/.config/matugen/papirus-folders/folder-color.txt"
[[ -f "$COLOR_FILE" ]] || exit 0

hex=$(<"$COLOR_FILE")
hex="${hex//$'\n'/}"
h="${hex#'#'}"

r=$((16#${h:0:2}))
g=$((16#${h:2:2}))
b=$((16#${h:4:2}))

# hsv: max, min, delta
max=$r; [[ $g -gt $max ]] && max=$g; [[ $b -gt $max ]] && max=$b
min=$r; [[ $g -lt $min ]] && min=$g; [[ $b -lt $min ]] && min=$b
delta=$((max - min))

if [[ $delta -lt 40 ]]; then
    # low saturation: grey
    variant="Grey"
else
    # hue ×100 for integer math
    if [[ $max -eq $r ]]; then
        hue=$(( 60 * (g - b) * 100 / delta ))
    elif [[ $max -eq $g ]]; then
        hue=$(( 12000 + 60 * (b - r) * 100 / delta ))
    else
        hue=$(( 24000 + 60 * (r - g) * 100 / delta ))
    fi
    [[ $hue -lt 0 ]] && hue=$((hue + 36000))
    hue=$((hue / 100))

    # map hue to variant
    if   [[ $hue -lt 20 ]] || [[ $hue -ge 345 ]]; then variant="Red"
    elif [[ $hue -lt 45 ]];  then variant="Orange"
    elif [[ $hue -lt 80 ]];  then variant="Yellow"
    elif [[ $hue -lt 165 ]]; then variant="Green"
    elif [[ $hue -lt 200 ]]; then variant="Teal"
    elif [[ $hue -lt 265 ]]; then variant="Blue"    # colloid-dark is blue
    elif [[ $hue -lt 300 ]]; then variant="Purple"
    else variant="Pink"
    fi
fi

if [[ "$variant" == "Blue" ]]; then
    theme="Colloid-Dark"
else
    theme="Colloid-${variant}-Dark"
fi

gsettings set org.gnome.desktop.interface icon-theme "$theme"
notify-send -u low -t 2000 "Icons" "$theme"
