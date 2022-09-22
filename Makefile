.PHONY: clean fclean re all makedir copy_resume generate_certs

###################################################################################
#                                Configurations                                   #
###################################################################################

DOCKER_COMPOSE  = docker compose

ENV_PATH        = ./srcs/.env
CONF_PATH       = ./srcs/docker-compose.yml
BONUS_DIR       = ./srcs/requirements/bonus
TOOLS_DIR       = ./srcs/requirements/tools
RESUME_PATH     = ${BONUS_DIR}/resume

include ${ENV_PATH}

IMAGES           = nginx mariadb wordpress redis adminer ftps cadvisor prometheus
VOLUMES_NAMES    = ${PV_MDB_NAME} ${PV_WP_NAME} ${PV_RESUME_NAME} ${PV_CERTS_NAME} ${PV_ADM_NAME} ${PV_MONITOR_NAME} 
VOLUMES_PATHS    = ${PV_MDB_PATH} ${PV_WP_PATH} ${PV_RESUME_PATH} ${PV_CERTS_PATH} ${PV_ADM_PATH} ${PV_MONITOR_PATH}

###################################################################################
#                                   Commands                                      #
###################################################################################

all: makedir copy_resume generate_certs
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} build --no-cache
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d 

makedir:
	mkdir -p ${VOLUMES_PATHS}

copy_resume:
	cp -r ${RESUME_PATH}/* ${PV_RESUME_PATH}

generate_certs:
	cp ${TOOLS_DIR}/gencert.sh ${PV_CERTS_PATH}
	chmod +x ${PV_CERTS_PATH}/gencert.sh
	cd ${PV_CERTS_PATH} && ./gencert.sh ${DOMAIN_NAME} ${DOMAIN_IP}
# Not working need to add crt explicitly to the browser
	sudo cp ${PV_CERTS_PATH}/mhufflep_CA.crt /etc/ssl/certs/mhufflep_CA.pem
	sudo update-ca-certificates

up:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d

down:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} down

stop:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} stop

ls:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ls

ps:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ps

logs:
	${DOCKER_COMPOSE} -f ${CONF_PATH} logs --tail=100 -f

pre:
	sudo docker stop $(docker ps -qa)
	sudo docker rm $(docker ps -qa)
	sudo docker rmi -f $(docker images -qa)
	sudo docker volume rm $(docker volume ls -q)
	sudo docker network rm $(docker network ls -q) 2>/dev/null

clean:
	sudo docker volume rm ${VOLUMES_NAMES} || exit 1
	sudo rm -rf ${VOLUMES_PATHS} || exit 1

