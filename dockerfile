# http://www.pawtec.com/lightscribe/
# http://www.yardbird.net/lightscribe/
# https://github.com/fcwu/docker-ubuntu-vnc-desktop


FROM dorowu/ubuntu-desktop-lxde-vnc:xenial

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y apt-utils wget locales && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.utf8

RUN mkdir -p /tmp && cd /tmp && \
    wget http://www.pawtec.com/lightscribe_files/Linux/LSS/lightscribe-1.18.27.10-linux-2.6-intel.deb && \
    wget http://www.pawtec.com/lightscribe_files/Linux/LSL/lightscribeApplications-1.18.15.1-linux-2.6-intel.deb && \
    wget http://www.yardbird.net/lightscribe/4l_1.0-r6_i386.deb && \
    wget http://www.yardbird.net/lightscribe/CD_Template.svg && \
    apt-get update && \
    apt-get install -y libsm6:i386 && \
    dpkg -i lightscribe-1.18.27.10-linux-2.6-intel.deb && \
    dpkg -i lightscribeApplications-1.18.15.1-linux-2.6-intel.deb && \
    dpkg -i 4l_1.0-r6_i386.deb 2>/dev/null || true && \
    apt-get --fix-broken install -y && \
    apt-get install -f -y && \
    dpkg --configure -a && \
    dpkg -i 4l_1.0-r6_i386.deb 2>/dev/null || true && \
    apt-get --fix-broken install -y

COPY 4L-gui.desktop SimpleLabeler.desktop /root/Desktop/

WORKDIR /tmp
