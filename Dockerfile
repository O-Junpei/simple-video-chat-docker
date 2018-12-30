FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  nginx \
  git \
  vim \
  wget \
  curl
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"
RUN apt-get install -y \
  swift \
  vapor

# COPY index.html /var/www/html
# RUN rm /var/www/html/index.nginx-debian.html

RUN rm /etc/nginx/nginx.conf
COPY vapor.conf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx

RUN mkdir /vapor
RUN git clone https://github.com/O-Junpei/simple-video-chat-server.git /vapor
WORKDIR /vapor
RUN swift build
RUN vapor build

EXPOSE 80

# chmod +x startup.sh
COPY startup.sh /
ENTRYPOINT ["/startup.sh"]
