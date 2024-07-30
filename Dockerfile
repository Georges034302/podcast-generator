FROM ubuntu:latest

RUN sudo apt-get install && apt upgrade python3
RUN sudo apt install && apt upgrade python3-pip
RUN sudo apt-get && apt upgrade install git

RUN sudo pip3 install PyYAML && apt upgrade PyYAML

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

