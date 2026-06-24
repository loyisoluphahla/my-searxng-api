FROM searxng/searxng:latest

# Copy our custom settings into the container
COPY settings.yml /etc/searxng/settings.yml

# Expose the default port
EXPOSE 8080
