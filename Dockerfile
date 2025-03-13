FROM prom/prometheus
# copy config template and startup script
COPY prometheus.yml /etc/prometheus/prometheus.template.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh
# Install envsubst utility from gettext package
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*
# expose port
EXPOSE 9090
# set entrypoint
USER root
ENTRYPOINT ["/start.sh"]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/prometheus", \
     "--storage.tsdb.retention.time=365d", \
     "--web.console.libraries=/usr/share/prometheus/console_libraries", \
     "--web.console.templates=/usr/share/prometheus/consoles", \
     "--web.external-url=http://localhost:9090", \
     "--log.level=info"]
