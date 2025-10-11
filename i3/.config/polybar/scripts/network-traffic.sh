#!/bin/bash

print_bytes() {
  if [ "$1" -lt 1000 ]; then
    output="$1 Bps"
  elif [ "$1" -lt 1000000 ]; then
    number=$(($1 / 1000))
    output="$number KBps"
  else
    number=$(($1 / 1000000))
    output="$number MBps"
  fi

  echo $output
}

INTERVAL=1
INTERFACES="eth0"

declare -A bytes

for interface in $INTERFACES; do
  bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
  bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

  # echo "$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
done

while true; do
  down=0
  up=0

  for interface in $INTERFACES; do

    bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
    bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

    bytes_down=$((((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]})) / INTERVAL))
    bytes_up=$((((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]})) / INTERVAL))

    down=$(((("$down" + "$bytes_down"))))
    up=$(((("$up" + "$bytes_up"))))

    bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
    bytes[past_tx_$interface]=${bytes[now_tx_$interface]}

    echo "TRAFFIC [  $(print_bytes $bytes_down)   $(print_bytes $bytes_up) ]"
  done

  sleep $INTERVAL
done
