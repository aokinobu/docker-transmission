FROM aokinobu/supervisord

MAINTAINER Nobuyuki Paul Aoki <aokinobu@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common 

RUN apt-get install -y transmission-daemon

ADD files/transmission-daemon /etc/transmission-daemon
ADD files/run_transmission.sh /run_transmission.sh

RUN mkdir -p /var/lib/transmission-daemon/incomplete && \
    mkdir -p /var/lib/transmission-daemon/downloads && \
    mkdir -p /var/lib/transmission-daemon/watch && \
    chown -R debian-transmission: /var/lib/transmission-daemon && \
    chown -R debian-transmission: /etc/transmission-daemon    

# where settings.json is
VOLUME ["/var/lib/transmission-daemon/.config/transmission-daemon"]
VOLUME ["/var/lib/transmission-daemon/downloads"]
VOLUME ["/var/lib/transmission-daemon/incomplete"]
VOLUME ["/var/lib/transmission-daemon/watch"]

EXPOSE 9091
EXPOSE 12345

#USER debian-transmission

CMD ["/run_transmission.sh"]
