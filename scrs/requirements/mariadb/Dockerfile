FROM debian:buster

# Mise à jour des paquets et installation de MariaDB + outils utiles
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Préparation des dossiers nécessaires à MySQL/MariaDB
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 755 /var/run/mysqld

# Exposition du port par défaut de MariaDB
EXPOSE 3306

# Copie des fichiers nécessaires au bon fonctionnement
COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
COPY ./conf/wordpress.sql /usr/local/bin/wordpress.sql

# Donne les droits d’exécution
RUN chmod +x /usr/local/bin/mariadb.sh

# Utilisation de ton script comme point d’entrée
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

# Commande par défaut pour lancer MariaDB avec écoute globale
CMD ["mysqld", "--bind-address=0.0.0.0"]
