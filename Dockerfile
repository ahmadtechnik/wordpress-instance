# Dockerfile for custom WordPress setup
#
# This file starts with the official WordPress image, which already includes wp-cli.
# It then copies and runs a script to install and activate a list of plugins.

FROM wordpress:latest

# Copy the plugin installation script into the container
COPY ./install-plugins.sh /usr/local/bin/install-plugins.sh

# Make the script executable
RUN chmod +x /usr/local/bin/install-plugins.sh

RUN mkdir "/docker-entrypoint-initwp.d/"

# The original entrypoint will be executed, and we can add our script
# to the initialization directory to have it run on first start.
# This is a robust way to ensure plugins are installed after WordPress is ready.
RUN mv /usr/local/bin/install-plugins.sh /docker-entrypoint-initwp.d/install-plugins.sh

