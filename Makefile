.PHONY: clean fclean re all makedir copy_resume generate_certs

###################################################################################
#                                Configurations                                   #
###################################################################################

DOCKER_COMPOSE  = docker compose

ENV_PATH        = ./srcs/.env
CONF_PATH       = ./srcs/docker-compose.yml
EXTRA_DIR       = ./srcs/requirements/bonus
TOOLS_DIR       = ./srcs/requirements/tools
RESUME_PATH     = ${EXTRA_DIR}/resume

include ${ENV_PATH}

IMAGES           = nginx mariadb wordpress redis adminer ftps
VOLUMES_NAMES    = ${PV_MDB_NAME} ${PV_WP_NAME} ${PV_RESUME_NAME} ${PV_CERTS_NAME}
VOLUMES_PATHS    = ${PV_MDB_PATH} ${PV_WP_PATH} ${PV_RESUME_PATH} ${PV_CERTS_PATH}

###################################################################################
#                                   Commands                                      #
###################################################################################

all: makedir copy_resume generate_certs
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} build
# ${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} build --no-cache
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d 

makedir:
	@mkdir -p ${VOLUMES_PATHS}

copy_resume:
	@cp -r ${RESUME_PATH} ${PV_RESUME_PATH}

generate_certs:
	@cp ${TOOLS_DIR}/gencert.sh ${PV_CERTS_PATH}
	@chmod +x ${PV_CERTS_PATH}/gencert.sh
	@cd ${PV_CERTS_PATH} && ./gencert.sh ${DOMAIN_NAME} ${DOMAIN_IP}

up:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} up -d

down:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} down

ls:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ls

ps:
	${DOCKER_COMPOSE} --env-file=${ENV_PATH} -f ${CONF_PATH} ps

clean:
	sudo docker image rm ${IMAGES}
	sudo docker volume rm ${VOLUMES_NAMES}
	sudo rm -rf ${VOLUMES_PATHS}