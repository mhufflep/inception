.PHONY: clean fclean re all makedir copy_resume generate_certs

###################################################################################
#                                Configurations                                   #
###################################################################################

COMPOSE   = docker compose

ENV_PATH  = ./srcs/.env
CONF_PATH = ./srcs/docker-compose.yml
BONUS_DIR = ./srcs/requirements/bonus
TOOLS_DIR = ./srcs/requirements/tools
CV_PATH   = ${BONUS_DIR}/resume

include ${ENV_PATH}

IMAGES        = nginx mariadb wordpress redis adminer ftps cadvisor prometheus
VOLUMES_NAMES = ${PV_MDB_NAME} ${PV_WP_NAME} ${PV_CV_NAME} ${PV_CERTS_NAME} ${PV_ADM_NAME} ${PV_MONITOR_NAME} 
VOLUMES_PATHS = ${PV_MDB_PATH} ${PV_WP_PATH} ${PV_CV_PATH} ${PV_CERTS_PATH} ${PV_ADM_PATH} ${PV_MONITOR_PATH}

###################################################################################
#                                   Commands                                      #
###################################################################################

all: makedir copy_resume generate_certs
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} build
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d 

makedir:
	mkdir -p ${VOLUMES_PATHS}

copy_resume:
	cp -r ${CV_PATH}/* ${PV_CV_PATH}

generate_certs:
	cp ${TOOLS_DIR}/gencert.sh ${PV_CERTS_PATH}
	chmod +x ${PV_CERTS_PATH}/gencert.sh
	cd ${PV_CERTS_PATH} && ./gencert.sh ${DOMAIN_NAME} ${DOMAIN_IP} ${LOGIN}

# Not working need to add crt explicitly to the browser
# sudo cp ${PV_CERTS_PATH}/mhufflep_CA.crt /etc/ssl/certs/mhufflep_CA.pem
# sudo update-ca-certificates

up:
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d

down:
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} down

stop:
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} stop

ls:
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ls

ps:
	${COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ps

logs:
	${COMPOSE} -f ${CONF_PATH} logs --tail=100 -f

pre:
	sudo docker stop $(shell docker ps -qa) || true
	sudo docker rm $(shell docker ps -qa) || true
	sudo docker rmi -f $(shell docker images -qa) || true
	sudo docker volume rm $(shell docker volume ls -q) || true
	sudo docker network rm $(shell docker network ls -q)  || true

clean:
	sudo docker volume rm ${VOLUMES_NAMES} || true
	sudo rm -rf ${VOLUMES_PATHS} || true

