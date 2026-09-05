FROM searxng/searxng:latest

USER root

# Install Tor using Debian's package manager (apt-get)
RUN apt-get update && \
    apt-get install -y --no-install-recommends tor && \
    rm -rf /var/lib/apt/lists/*

# Copy your configuration files into place
COPY settings.yml /etc/searxng/settings.yml
COPY limiter.toml /etc/searxng/limiter.toml
COPY start.sh /usr/local/bin/start.sh

# Make sure the startup script is executable
RUN chmod +x /usr/local/bin/start.sh

# Expose SearXNG's internal port
EXPOSE 8080

# Run our custom startup script that handles both Tor and SearXNG
ENTRYPOINT ["/usr/local/bin/start.sh"]
