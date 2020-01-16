FROM httpd:latest
WORKDIR /usr/local/apache2/htdocs/
COPY ./public-html/* .
RUN apt-get update && apt-get install curl -y
EXPOSE 80


