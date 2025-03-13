FROM prom/prometheus
# copy config template and startup script
COPY prometheus.yml /etc/prometheus/prometheus.template.yml
COPY start.sh /start.sh

# Install envsubst utility from gettext package and set permissions
USER root
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/* && \
    chmod +x /start.sh

# expose port
EXPOSE 9090

# Switch back to prometheus user for better security
USER prometheus

ENTRYPOINT ["/start.sh"]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/prometheus", \
     "--storage.tsdb.retention.time=365d", \
     "--web.console.libraries=/usr/share/prometheus/console_libraries", \
     "--web.console.templates=/usr/share/prometheus/consoles", \
     "--web.external-url=http://localhost:9090", \
     "--log.level=info"]
