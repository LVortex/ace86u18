FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp

# set ports
EXPOSE 8621 62062 6878 8000 8090

RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y \
build-essential \
python-dev \
python2.7 \
gcc \
curl \
wget \
git \
mc \
nano \
iputils-ping \
tzdata \
locales \
htop && \
# Set the locale
locale-gen ru_RU.UTF-8 && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py && \
pip install --upgrade psutil && \
pip install jinja2 && \
pip install setuptools cffi 'cython>=0.27' git+git://github.com/gevent/gevent.git#egg=gevent && \
apt-get purge git python-dev gcc build-essential -y && \
apt-get autoremove -y && \

#acestream
mkdir -p /opt/acestream/ && \
wget -o - https://sybdata.de/files/public-docs/acestream_3.1.31_webUI_x86.tar.gz && \
tar -zxvf acestream_3.1.31_webUI_x86.tar.gz && \
mv androidfs /opt/acestream/androidfs && \
find /opt/acestream/androidfs/system -type d -exec chmod 755 {} \; && \
find /opt/acestream/androidfs/system -type f -exec chmod 644 {} \; && \
chmod 755 /opt/acestream/androidfs/system/bin/* /opt/acestream/androidfs/acestream.engine/python/bin/python && \

# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# install TorrServer
mkdir -p /opt/TorrServer/ && \
wget https://github.com/YouROK/TorrServe/raw/master/TorrServer/dist/TorrServer-linux-amd64 && \
mv TorrServer-linux-amd64 /opt/TorrServer/ && \
chmod +x /opt/TorrServer/TorrServer-linux-amd64 && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*
ADD start.sh /start.sh
ADD acestream.start /opt/acestream/acestream.start
ADD acestream.stop /opt/acestream/acestream.stop
ADD acestream.conf /opt/acestream/androidfs/acestream.engine/acestream.conf
RUN chmod +x /start.sh
RUN chmod +x /opt/acestream/acestream.start
RUN chmod +x /opt/acestream/acestream.stop
WORKDIR /
