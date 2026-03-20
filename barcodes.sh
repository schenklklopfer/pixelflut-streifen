#!/bin/bash

SERVER="10.55.4.10";
BUFFER=/dev/shm/asdf
PORT=1234; #echo "" > $BUFFER_*
THREADS="8"

function gen_color() {
string="$(openssl rand -hex 6000)"
length=6

for ((i=0; i<${#string}; i+=length)); do
  echo "${string:i:length}"
done
}

function send() {
        cat ${BUFFER}_${1} | mbuffer > /dev/tcp/$SERVER/$PORT; #echo "" > ${BUFFER}_${1}
}

function calc() {
	Xm=$(shuf -i 3-300 -n 1)
        Ym=$(shuf -i 2-100 -n 1)
#	Xm="5"; Ym="5"
#	OFFMAXX=$((3840 - Xm))
#	OFFMAXY=$((2160 - Ym))
        OFFSETX=$(shuf -i 1-3700 -n 1)
        OFFSETY=$(shuf -i 1-2200 -n 1)
	Xmin=$OFFSETX
	Ymin=$OFFSETY
	Xmax=$((Xm + OFFSETX))
	Ymax=$((Ym + OFFSETY))
        for X in $(seq $Xmin $Xmax); do
                for Y in $(seq $Ymin $Ymax); do
                        echo "PX $X $Y $COLOR" >> ${BUFFER}_${1}
                        #echo "X: $X Y: $Y"
                        #let Y++
			((Y++))
#                done &
		done
                #echo "X: $X"
                #let X++
		((X++))
        done
}

function test() {
:
}

COUNTER="1"
while true; do
        #COLOR=$(echo "$(openssl rand -hex 3)"); echo $COLOR
	for COLOR in $(gen_color); do
		echo $COLOR
		for COUNTER in $(seq 1 $THREADS); do
		        calc $COUNTER &
	        	send $COUNTER
		done

                for COUNTER in $(seq 1 $THREADS); do
			echo "" > ${BUFFER}_${COUNTER}
                done

	done
exit
done
