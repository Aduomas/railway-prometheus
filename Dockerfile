FROM prom/prometheus

# Copy config template and startup script
COPY prometheus.yml /etc/prometheus/prometheus.template.yml
COPY start.sh /bin/start.sh

# Create a simpler start script that doesn't rely on envsubst
RUN echo '#!/bin/sh' > /bin/start.sh && \
    echo 'sed -e "s|\${FASTAPI_URL}|$FASTAPI_URL|g" /etc/prometheus/prometheus.template.yml > /etc/prometheus/prometheus.yml' >> /bin/start.sh && \
    echo 'exec /bin/prometheus "$@"' >> /bin/start.sh && \
    chmod +x /bin/start.sh

# Expose port
EXPOSE 9090

ENTRYPOINT ["/bin/start.sh"]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/prometheus", \
     "--storage.tsdb.retention.time=365d", \
     "--web.console.libraries=/usr/share/prometheus/console_libraries", \
     "--web.console.templates=/usr/share/prometheus/consoles", \
     "--web.external-url=http://localhost:9090", \
     "--log.level=info"]
