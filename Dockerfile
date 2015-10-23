FROM node:0.12

MAINTAINER fpt-softare

# install node-red
RUN npm install -g node-red

# expose port
EXPOSE 1880

# Set the default command to execute
# when creating a new container
CMD ["/usr/local/bin/node-red"]
