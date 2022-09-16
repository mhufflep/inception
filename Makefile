.PHONY: clean fclean re all makedir

###################################################################################
#                                Configurations                                   #
###################################################################################

SHELL := /bin/bash 

COMPOSE     = docker compose

MDB_PV_NAME = mdb_pv
WP_PV_NAME  = wp_pv

MDB_PV_PATH = /home/mhufflep/data/mdb
WP_PV_PATH  = /home/mhufflep/data/wp

CONF_PATH   = ./srcs/docker-compose.yml

# Why resume should present in the /home/data dir?
RESUME_LOCAL_PATH = ./srcs/requirements/bonus/resume/
RESUME_VOLUME_PATH = /home/data/mhufflep/

###################################################################################
#                                   Commands                                      #
###################################################################################

makedir:
	@mkdir -p ${MDB_PV_PATH} ${WP_PV_PATH}

copy_site:
	@cp -r ${RESUME_LOCAL_PATH} ${RESUME_VOLUME_PATH}

all: makedir
	${MDB_PV_PATH} ${WP_PV_PATH} ${COMPOSE} -f ${CONF_PATH} build
	${MDB_PV_PATH} ${WP_PV_PATH} ${COMPOSE} -f ${CONF_PATH} up -d

up:
	${COMPOSE} -f ${CONF_PATH} up -d

down:
	${COMPOSE} -f ${CONF_PATH} down

ls:
	${COMPOSE} -f ${CONF_PATH} ls

ps:
	${COMPOSE} -f ${CONF_PATH} ps

clean:
	sudo docker image rm nginx mariadb wordpress
	sudo docker volume rm ${MDB_PV_NAME} ${WP_PV_NAME}
	sudo rm -rf ${MDB_PV_PATH}/* ${WP_PV_PATH}/*