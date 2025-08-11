# Inception

## Description

Inception est un projet visant à déployer une stack web complète en local à l’aide de Docker Compose. Il intègre plusieurs services essentiels tels que Nginx, WordPress, MariaDB et phpMyAdmin, facilitant ainsi l’apprentissage de la gestion de conteneurs, la configuration serveur et l’orchestration d’applications.

---

## Technologies utilisées

- **Docker & Docker Compose** : pour la gestion des conteneurs et l'orchestration des services.
- **Nginx** : serveur web performant servant de reverse proxy pour WordPress.
- **WordPress** : système de gestion de contenu (CMS) pour la création de sites web.
- **MariaDB** : système de gestion de base de données relationnelle compatible avec MySQL.

---

## Installation

### Prérequis

- **Système d'exploitation** : Linux (Debian/Ubuntu recommandé)
- **Docker** : version 20.10 ou supérieure
- **Docker Compose** : version 1.29 ou supérieure

### Installer Docker et Docker Compose sur Linux

Ouvre un terminal et exécute les commandes suivantes :

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
```

## Lancement du projet

### Cloner le dépôt
Clone le projet depuis GitHub et accède au dossier :
```bash 
git clone https://github.com/vialaenzo/inception.git
cd inception
```

### Démarrer la stack
Lance la stack complète en arrière-plan avec Docker Compose :
```bash 
docker compose up -d
```

Cette commande va télécharger les images Docker nécessaires, construire les images personnalisées, et lancer les conteneurs pour chaque service (Nginx, WordPress, MariaDB).

### Vérifier que tout fonctionne
Vérifie que les conteneurs sont bien lancés :

```bash 
docker compose ps
```

Tu dois voir tous les services listés et en statut **Up**.

## Utilisation du projet
### Accéder aux services
- **WordPress :** 
  Ouvre un navigateur et va sur http://localhost:5050.
  Tu y trouveras l’interface WordPress pour créer et gérer un site web.

### Gestion de la stack
- Pour suivre les logs en temps réel :
  ```bash
    docker compose logs -f
  ```
- Pour arrêter la stack et les conteneurs :
  ```bash
    docker compose down
  ```
- Pour reconstruire les images (utile après modification des fichiers de configuration ou du code) :
  ```bash
  docker compose up -d --build
  ```

Par la suite, vous pouvez tester le projet.
