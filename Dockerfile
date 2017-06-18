FROM yyolk/rpi-archlinuxarm
MAINTAINER Tarrence van As <tarrence13@gmail.com>

# install required packages
RUN pacman -Syu --noconfirm --ignore ca-certificates-utils
RUN pacman -S --noconfirm --force ca-certificates-utils
RUN pacman-db-upgrade
RUN pacman -Sy git sudo unzip wget --noconfirm

# install RPi.GPIO
RUN pacman -Sy python2 python2-pip gcc make --noconfirm
ENV PYTHON /bin/python2
RUN pip2 install RPi.GPIO
RUN touch /usr/share/doc/python-rpi.gpio

# install rpi tools
RUN pacman -Sy raspberrypi-firmware-tools --noconfirm

ENV PATH /opt/vc/bin:$PATH

RUN wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update && \
    chmod +x /usr/bin/rpi-update

RUN rpi-update

RUN printf "gpu_mem_512=316\ngpu_mem_256=128\ncma_lwm=\ncma_hwm=\ncma_offline_start=\nstart_x=1" >> /boot/config.txt
