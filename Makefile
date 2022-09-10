SHELL := /bin/bash 

all:
	mkdir -p /home/mhufflep/data/db
	mkdir -p /home/mhufflep/data/wp
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

ls:
	docker-compose -f srcs/docker-compose.yml ls

ps:
	docker-compose -f srcs/docker-compose.yml ps

clean:
	sudo docker image rm nginx-image
	sudo docker image rm mariadb-image
	sudo docker image rm wordpress-image
	sudo docker volume rm wp
	sudo docker volume rm db
	sudo rm -rf /home/mhufflep/data/db/*
	sudo rm -rf /home/mhufflep/data/wp/*