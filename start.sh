#!/bin/sh
set -e

# ---- Start Tor ONLY if it's enabled (proxy removed from settings.yml) ----
# Default: Tor is OFF. Set START_TOR=1 if you genuinely need it.
if [ "${START_TOR:-0}" = "1" ]; then
  echo "Starting Tor proxy..."
  tor --RunAsDaemon 1

  # Wait until the SOCKS port (9050) actually accepts connections
  echo "Waiting for Tor to bootstrap..."
  i=0
  until (echo > /dev/tcp/127.0.0.1/9050) 2>/dev/null; do
    i=$((i+1))
    if [ "$i" -ge 30 ]; then
      echo "Tor did not become ready in time. Continuing without it." >&2
      break
    fi
    sleep 1
  done
  echo "Tor is ready."
fi

echo "Starting SearXNG..."
exec python3 -m searx.webapp
