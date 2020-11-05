FROM debian:buster-slim

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  avr-libc=1:2.0.0+Atmel3.6.1-2 \
  gcc-avr=1:5.4.0+Atmel3.6.1-2 \
  gcc=4:8.3.0-1 \
  libc6-dev=2.28-10 \
  libusb-dev=2:0.1.12-32 \
  make=4.2.1-1.2

WORKDIR /printrboard-updater

CMD make
