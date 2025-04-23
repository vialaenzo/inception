# Variables
NAME = inception
DOCKER_COMPOSE = docker-compose -f ./scrs/docker-compose.yml

# Targets
all: up

up:
	@$(DOCKER_COMPOSE) up --build -d

down:
	@$(DOCKER_COMPOSE) down

re: fclean all

fclean:
	@$(DOCKER_COMPOSE) down --volumes --remove-orphans
	@docker system prune -af --volumes

ps:
	@$(DOCKER_COMPOSE) ps

logs:
	@$(DOCKER_COMPOSE) logs -f

.PHONY: all up down re fclean ps logs
