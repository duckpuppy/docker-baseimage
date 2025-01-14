FROM phusion/baseimage:0.9.18
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm" 
COPY sources.list /etc/apt/sources.list
COPY *.sh /etc/my_init.d/
RUN useradd -u 911 -U -d /config -s /bin/false abc && usermod -G users abc && mkdir -p /app/aptselect /config /defaults && \ 
curl -L https://github.com/jblakeman/apt-select/archive/master.tar.gz | tar xvz -C /app/aptselect --strip-components=1 && \
apt-get update && apt-get install -y python3-bs4 && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && chmod +x /etc/my_init.d/*.sh && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]

