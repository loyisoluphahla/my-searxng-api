# Optionally skip Tor when you don't need it: --build-arg INSTALL_TOR=0
ARG INSTALL_TOR=1

FROM searxng/searxng:latest

USER root

RUN apt-get update && \
    if [ "$INSTALL_TOR" = "1" ]; then \
        apt-get install -y --no-install-recommends tor; \
    fi && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration into place
COPY settings.yml /etc/searxng/settings.yml
COPY limiter.toml /etc/searxng/limiter.toml
COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/start.sh"]
