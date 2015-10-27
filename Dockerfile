# Set nginx base image
FROM node:0.12

MAINTAINER cpswan

# Define working directory
RUN mkdir -p /var/seniot/
WORKDIR /var/seniot
ADD . /var/seniot

# install node-red from seniot/ repository
RUN git clone https://github.com/seniot/node-red.git /var/seniot/workflow
RUN cd /var/seniot/workflow/
RUN npm install
RUN npm update
RUN npm install -g grunt-cli
RUN grunt build
RUN node red

# expose port
EXPOSE 1880
