FROM ubuntu:latest

RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y git

RUN pip3 install PyYAML

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

