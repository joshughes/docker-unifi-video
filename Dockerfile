FROM debian:wheezy

RUN echo "deb [arch=amd64] http://www.ubnt.com/downloads/unifi-video/apt wheezy  ubiquiti" > /etc/apt/sources.list.d/unifi-video.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 97B46B8582C6571E

RUN apt-get update && apt-get install -y supervisor unifi-video

VOLUME /var/lib/unifi-video
VOLUME /var/log/unifi-video

EXPOSE  7447 7446 1935 7443 7080 6666 80 443 554 22


# launcher config
ADD ./supervisord.conf /etc/supervisor/conf.d/unifi-video.conf
ADD ./unifi-video.default /etc/default/unifi-video


WORKDIR /usr/lib/unifi-video
CMD ["/usr/bin/supervisord"]

