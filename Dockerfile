FROM debian:jessie
MAINTAINER Sumi Straessle

ENV DEBIAN_FRONTEND noninteractive

# NB ntp is set in base VM (host on linux hosts, most likely boot2docker on Windows and Mac)
# Time of the containers is the time of the host machine

# Set the locale (Debian removed dependency to locale in 2011)
RUN apt-get update \
	&& apt-get install -y locales locales-all curl git htop man software-properties-common unzip vim wget \
	&& echo "fr_CH.UTF-8 UTF-8" > /etc/locale.gen \
	&& locale-gen fr_CH.UTF-8 \
	&& update-locale LANG=fr_CH.UTF-8 \
	&& cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime \
	&& echo "Europe/Zurich" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& printf 'LANG=fr_CH.utf8\nLANGUAGE=fr_CH:fr\nLC_CTYPE="fr_CH.utf8"\nLC_ALL=fr_CH.utf8'>/etc/default/locale

# Set environment variables for locale
ENV LANG fr_CH.UTF-8  
ENV LANGUAGE fr_CH:fr
ENV LC_ALL fr_CH.UTF-8 

# supervisor installation && 
# create directory for child images to store configuration in
RUN apt-get -y install supervisor && \
  mkdir -p /var/log/supervisor && \
  mkdir -p /etc/supervisor/conf.d

# Upgrade system
RUN apt-get -y upgrade

# supervisor base configuration
ADD supervisor.conf /etc/supervisor.conf

# Clean
RUN apt-get clean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# default command
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
