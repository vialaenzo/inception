FROM debian:buster

# Install nginx and openssl
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Créer les certificats SSL auto-signés
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/eviala.crt \
    -keyout /etc/nginx/ssl/eviala.key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=eviala/CN=eviala.42.fr"

# Copier la config nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Préparer le dossier requis pour nginx
RUN mkdir -p /run/nginx

# Exposer uniquement le port 443
EXPOSE 443

# Lancer nginx en mode non-démon
CMD ["nginx", "-g", "daemon off;"]
