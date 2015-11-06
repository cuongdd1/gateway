# Set node base image
FROM node:0.12

MAINTAINER fpt-softwre

# Define working directory
RUN mkdir -p /var/seniot/
# install node-red from seniot/ repository
WORKDIR /var/seniot
ADD . /var/seniot
RUN git clone https://github.com/seniot/node-red.git /var/seniot/workflow
RUN git --git-dir=/var/seniot/workflow/.git --work-tree=/var/seniot/workflow/ checkout tags/v0.1.1
RUN git clone https://github.com/seniot/node-red-nodes.git /var/seniot/workflow/nodes/node-red-nodes
RUN git --git-dir=/var/seniot/workflow/nodes/node-red-nodes/.git --work-tree=/var/seniot/workflow/nodes/node-red-nodes/ checkout tags/v0.1.1

RUN cd /var/seniot/workflow/ \	
	&& git pull \
	&& npm install \
	&& npm update \
	&& npm install -g grunt-cli \
	&& grunt build
	
RUN cd /var/seniot/workflow/nodes/node-red-nodes/ \	
	&& git pull \
	&& npm install \
	&& npm update

# expose port
EXPOSE 1880

# Run app using nodemon
CMD ["node", "/var/seniot/workflow/red.js"]