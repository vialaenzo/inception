FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y;
RUN apt-get install -y nginx openssl;

RUN mkdir -p /etc/nginx/ssl;
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
        /etc/nginx/ssl/inception.key -subj "/C=FR/L=Paris/CN=domain_name.fr";

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress;
RUN chown -R www-data:www-data /var/www/wordpress;

CMD ["nginx", "-g", "daemon off;"]
