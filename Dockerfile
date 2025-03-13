FROM prom/prometheus

# Copy our custom prometheus.yml directly
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Expose port
EXPOSE 9090

# Just use the default entrypoint and specify the config file
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/prometheus", \
     "--storage.tsdb.retention.time=365d", \
     "--web.console.libraries=/usr/share/prometheus/console_libraries", \
     "--web.console.templates=/usr/share/prometheus/consoles", \
     "--web.external-url=http://localhost:9090", \
     "--log.level=info"]
