# Variables
WP_DATA = /home/eviala/data/wordpress  # Chemin des données de WordPress
DB_DATA = /home/eviala/data/mariadb    # Chemin des données de MariaDB
DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_DIR = ../data

# Default target
all: up

# Préparation des répertoires de données
prepare_dirs:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb
	@echo "📁 Dossiers de données préparés dans $(DATA_DIR)"

# Création des répertoires et démarrage des conteneurs
up: prepare_dirs
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@$(DOCKER_COMPOSE) up --build -d
	@echo "🚀 Containers démarrés en arrière-plan"

# Arrêter les conteneurs
down:
	@$(DOCKER_COMPOSE) down
	@echo "🛑 Conteneurs arrêtés"

# Stopper les conteneurs sans les supprimer
stop:
	@$(DOCKER_COMPOSE) stop
	@echo "⏸️ Conteneurs stoppés"

# Démarrer les conteneurs
start:
	@$(DOCKER_COMPOSE) start
	@echo "▶️ Conteneurs démarrés"

# Construire les conteneurs
build:
	@$(DOCKER_COMPOSE) build
	@echo "🔨 Conteneurs construits"

# Clean: stoppe et supprime tous les conteneurs, images, volumes, et réseaux
clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true
	@echo "🧹 Nettoyage terminé : conteneurs, images, volumes et données supprimés"

# Rebuild et démarrage des conteneurs après nettoyage
re: clean up

# Supprimer tous les conteneurs, images, volumes, et réseaux
prune: clean
	@docker system prune -a --volumes -f
	@echo "🧹 Système purgé : conteneurs, images, volumes et réseaux supprimés"

# Afficher l'état des conteneurs
ps:
	@$(DOCKER_COMPOSE) ps
	@echo "📊 Affichage des conteneurs en cours"

# Afficher les logs des conteneurs
logs:
	@$(DOCKER_COMPOSE) logs -f
	@echo "📜 Affichage des logs"

.PHONY: all up down stop start build clean re prune ps logs prepare_dirs
