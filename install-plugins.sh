#!/bin/bash

# This script runs on the first startup of the WordPress container.
# It uses wp-cli to install and activate a list of specified plugins.
# The --allow-root flag is necessary because the entrypoint script runs as root.

set -e

# --- Customize your plugins here ---
# Add the slugs of the plugins you want to install.
# You can find the slug in the URL of the plugin on wordpress.org.
# For example, for "Yoast SEO", the URL is https://wordpress.org/plugins/wordpress-seo/,
# but the slug is just "yoast". A quick search usually finds the correct slug.
PLUGINS_TO_INSTALL=(
    "elementor"
    "contact-form-7"
    "yoast"
    "wordfence"
    "wp-mail-smtp"
)
# ------------------------------------

echo "Starting plugin installation process..."

# The official WordPress entrypoint script waits for the database to be ready,
# so we can proceed directly with wp-cli commands.
for plugin in "${PLUGINS_TO_INSTALL[@]}"; do
    if ! wp plugin is-installed "$plugin" --allow-root; then
        echo "Installing and activating plugin: $plugin"
        wp plugin install "$plugin" --activate --allow-root
    else
        echo "Plugin $plugin is already installed. Skipping."
    fi
done

echo "All specified plugins have been installed and activated."

