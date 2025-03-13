#!/bin/sh
# Replace environment variables in config file
envsubst < /etc/prometheus/prometheus.template.yml > /etc/prometheus/prometheus.yml
# Start Prometheus with all arguments passed to the script
exec /bin/prometheus "$@"
