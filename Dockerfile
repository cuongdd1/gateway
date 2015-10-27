# Set nginx base image
FROM node:0.12

MAINTAINER cpswan

# Define working directory
RUN mkdir -p /var/seniot/
# install node-red from seniot/ repository
WORKDIR /var/seniot
ADD . /var/seniot
RUN git clone https://github.com/seniot/node-red.git /var/seniot/workflow
RUN cd /var/seniot/workflow/ \
	&& npm install \
	&& npm update \
	&& npm install -g grunt-cli \
	&& grunt build \
	&& node red

# expose port
EXPOSE 1880
