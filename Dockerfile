FROM centos

COPY prometheus /prometheus

RUN cd /prometheus && \
    mv prometheus /bin/ && \
    mv promtool /bin/ && \
    mkdir /usr/share/prometheus /opt/prometheus && \
    mv console_libraries /usr/share/prometheus/console_libraries/ && \
    mv consoles/ /usr/share/prometheus/consoles/ && \
    mkdir /etc/prometheus && \
    cp prometheus.yml /etc/prometheus/ && \
    cd && \
    rm -rf /prometheus && \
    chgrp -R 0 /opt && \
    chmod -R g=u /opt

WORKDIR /usr/share/prometheus

VOLUME /opt/prometheus
VOLUME /etc/prometheus

EXPOSE 9090

ENTRYPOINT ["/bin/prometheus"]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/opt/prometheus"]