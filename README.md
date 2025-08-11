# Inception

## Description

Inception est un projet qui permet de déployer une stack web complète en local à l’aide de Docker Compose.  
Il intègre plusieurs services essentiels comme Nginx, WordPress, MariaDB, et phpMyAdmin, facilitant ainsi l’apprentissage de la gestion de conteneurs, la configuration serveur, et l’orchestration d’applications.

---

## Technologies utilisées

- Docker & Docker Compose  
- Nginx  
- WordPress  
- MariaDB  

---

## Installation

### Prérequis

- Linux (Debian / Ubuntu recommandé)

### Installer Docker et Docker Compose sur Linux

Ouvre un terminal et lance ces commandes :

```bash
# Mettre à jour la liste des paquets
sudo apt update

# Installer les paquets nécessaires pour permettre à apt d'utiliser un dépôt via HTTPS
sudo apt install -y ca-certificates curl gnupg lsb-release

# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Configurer le dépôt stable Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour la liste des paquets à nouveau
sudo apt update

# Installer Docker Engine, CLI et containerd
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Vérifier que Docker est installé et fonctionne
sudo systemctl status docker

# Pour éviter de taper sudo à chaque commande Docker, ajouter ton utilisateur au groupe docker
sudo usermod -aG docker $USER

# Se déconnecter/reconnecter ou lancer :
newgrp docker

# Vérifier la version de Docker
docker --version

# Vérifier la version de Docker Compose
docker compose version
