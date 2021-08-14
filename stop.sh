#STATE=$(docker ps -l)

CONTAINER_ID=$(docker ps -lq)
if test -z "$CONTAINER_ID"
then
	echo "There's no running container"
else
	docker stop "${CONTAINER_ID}"
	echo "Container $CONTAINER_ID stopped."
	docker rm "${CONTAINER_ID}"
	echo "Container $CONTAINER_ID deleted."
fi
#docker rmi $(docker )