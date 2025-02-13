# Fetch battery information
BATTERY_PATH="/sys/class/power_supply/BAT0"
CAPACITY=$(cat "$BATTERY_PATH/capacity")
STATUS=$(cat "$BATTERY_PATH/status")

# Prepare the display output
if [ "$STATUS" == "Charging" ]; then
    ICON=" "
elif [ "$CAPACITY" -le 20 ]; then
    ICON=" "
elif [ "$CAPACITY" -le 40 ]; then
    ICON=" "
elif [ "$CAPACITY" -le 60 ]; then
    ICON=" "
elif [ "$CAPACITY" -le 80 ]; then
    ICON=" "
else
    ICON=" "
fi

# Print the status line
echo "$ICON$CAPACITY%"
