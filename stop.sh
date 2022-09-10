#!/bin/bash

CONT_IDS="$(docker ps -a -q)"

for	id in $CONT_IDS
do
	#CONTAINER_ID=$(docker ps -lq)
	if test -z "$id"
	then
		echo "There's no running $id container"
	else
		docker stop "${id}"
		
		if [ $? == 0 ]; then
			echo "Container $id stopped."
		fi
		
		docker rm "${id}"
		
		if [ $? == 0 ]; then
			echo "Container $id deleted."
		fi
	fi

done
