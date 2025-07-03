#!/bin/bash

# This script runs on the first startup of the WordPress container.
# It uses wp-cli to install and activate a list of specified plugins.
# The --allow-root flag is necessary because the entrypoint script runs as root.

set -e

# --- Customize your plugins here ---
# Add the slugs of the plugins you want to install.
# Define list of plugins to install
PLUGINS_TO_INSTALL=(
    "contact-form-7"
    "woocommerce"
    "members"
    "admin-menu-editor"       # Admin menu enhancement
    "file-manager-advanced"   # File manager plugin
    "jetpack"
    "seo-by-rank-math"        # Rank Math SEO
    "wordfence"
    "wp-mail-smtp"
)
# ------------------------------------

echo "Starting plugin installation process..."

# The official WordPress entrypoint script waits for the database to be ready.
for plugin in "${PLUGINS_TO_INSTALL[@]}"; do
    if ! wp plugin is-installed "$plugin" --allow-root; then
        echo "Installing and activating plugin: $plugin"
        wp plugin install "$plugin" --activate --allow-root
    else
        echo "Plugin $plugin is already installed. Skipping."
    fi
done

echo "All specified plugins have been installed and activated."

