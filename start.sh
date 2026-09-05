#!/bin/sh

# Start Tor in the background
echo "Starting Tor proxy..."
tor --RunAsDaemon 1

# Wait briefly for Tor to initialize its circuit
sleep 3

# Start the primary SearXNG application via granian
echo "Starting SearXNG..."
exec python3 -m searx.webapp