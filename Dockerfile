# Dockerfile for custom WordPress setup
#
# This file starts with the official WordPress image, which already includes wp-cli.
# It then copies and runs a script to install and activate a list of plugins.

FROM wordpress:latest

# Copy the plugin installation script into the container
COPY ./install-plugins.sh /usr/local/bin/install-plugins.sh

# Make the script executable
RUN chmod +x /usr/local/bin/install-plugins.sh

RUN /usr/local/bin/install-plugins.sh