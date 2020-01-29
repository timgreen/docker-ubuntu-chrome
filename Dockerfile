FROM ubuntu:18.04

# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

# Timezone
ENV TZ=Australia/Sydney
RUN \
  apt-get update && \
  apt-get install -y tzdata && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install Node.js 13
RUN \
  apt-get install -y wget && \
  wget -q -O - https://deb.nodesource.com/setup_13.x | bash - && \
  apt-get install -y nodejs

# Dev tools
RUN \
  apt-get install -y make g++

# Install Chromium, for the necessary shared library dependencies.
# See https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-unstable

# Install xvfb
RUN \
  apt-get install -y xvfb && \
  rm -rf /var/lib/apt/lists/*
