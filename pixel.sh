#!/bin/bash

if [ -z "$1" ]; then exit 1; else SERVER="$1"; fi
if [ -d "/mnt/tmpfs" ]; then BUFFER=/mnt/tmpfs/buffer; else BUFFER=/tmp/buffer; fi
PORT=1234; echo "" > $BUFFER

function send() {
        cat $BUFFER | mbuffer > /dev/tcp/$SERVER/$PORT; echo "" > $BUFFER
}

function calc() {
        SIZE="$(echo SIZE | timeout 0.5 nc $SERVER $PORT)"
        if [ -z "$SIZE" ]; then
                echo server offline; exit 1
        fi
        Xm="$(echo $SIZE | awk '{print $2}')"
        Ym="$(echo $SIZE | awk '{print $3}')"

        for X in $(seq 0 $Xm); do
                for Y in $(seq 0 $Ym); do
                        echo "PX $X $Y $COLOR" >> $BUFFER
                        #echo "X: $X Y: $Y"
                        let Y++
                done &
                #echo "X: $X"
                let X++
        done
}

while true; do
        COLOR=$(echo "$(openssl rand -hex 3)"); echo $COLOR
        calc
        send
done
