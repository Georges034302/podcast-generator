FROM ubuntu:latest

RUN apt-get install && apt upgrade python3
RUN apt install && apt upgrade python3-pip
RUN apt-get && apt upgrade install git

RUN pip3 install PyYAML && apt upgrade PyYAML

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

