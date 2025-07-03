# Start from official WordPress image
FROM wordpress:latest

# Update system and install required tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y less curl mariadb-client unzip && \
    rm -rf /var/lib/apt/lists/*

# Ensure wp-cli is present (usually already included)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy your script to the WordPress root directory
COPY ./install-plugins.sh /var/www/html/install-plugins.sh

# Set correct permissions for www-data
RUN chmod +x /var/www/html/install-plugins.sh && \
    chown www-data:www-data /var/www/html/install-plugins.sh

# Run the script during build (optional)
# If you want to run it at build time (make sure WP is initialized):
# USER www-data
# RUN wp plugin install akismet --activate

# Optional: switch to www-data for runtime consistency
USER www-data
