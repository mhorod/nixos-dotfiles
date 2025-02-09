set saved $(cat /home/mhorod/.config/waybar/wallpaper-name.txt)
set current $(wpaperctl get eDP-1)
if test $saved = $current
  exit 0
else
  echo $current > /home/mhorod/.config/waybar/wallpaper-name.txt
  wal -i $current -st
  pkill -SIGUSR2 waybar &
end
