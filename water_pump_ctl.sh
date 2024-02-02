#!/bin/bash

while true; do
    # Get the status using liquidctl
    status=$(sudo liquidctl status)

    # Extract values using awk
    value1=$(echo "$status" | awk '/Liquid temperature/ {print $4}')
    value2=$(echo "$status" | awk '/Pump speed/ {print $4}')

    # Check if value1 is above 30 and value2 is below 1950
    if (( $(echo "$value1 > 30" | bc -l) )) && (( $(echo "$value2 < 1950" | bc -l) )); then
        # Run the command to set pump speed to 100
        sudo liquidctl set pump speed 100
        echo "Setting pump speed to 100"

    # Check if value1 is below 30 and value2 is above 1950
    elif (( $(echo "$value1 < 30" | bc -l) )) && (( $(echo "$value2 > 1950" | bc -l) )); then
        # Run the command to set pump speed to 1
        sudo liquidctl set pump speed 1
        echo "Setting pump speed to 1"
    fi

    # Sleep for 5 seconds before the next iteration
    sleep 5
done
