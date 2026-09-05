FROM docker.io/searxng/searxng:latest

# Switch to root to install Tor and configure permissions
USER root

# Install Tor
RUN apk add --no-cache tor

# Copy your configuration files into place
COPY settings.yml /etc/searxng/settings.yml
COPY limiter.toml /etc/searxng/limiter.toml

# Copy the startup script and make it executable
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Expose the SearXNG web port
EXPOSE 8080

# Run Tor and SearXNG via the custom shell script
CMD ["/usr/local/bin/start.sh"]