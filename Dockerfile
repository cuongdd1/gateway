# Set nginx base image
FROM nginx

MAINTAINER fpt-softare

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf

# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

# expose port
EXPOSE 80
EXPOSE 443

VOLUME ["/etc/nginx/certs"]