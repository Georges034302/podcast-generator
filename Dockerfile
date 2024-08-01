FROM ubuntu:22.04

RUN apt-get update && apt-get install -y python3.10 python3-pip git

RUN pip3 install PyYAML lxml

COPY trailer.py /usr/bin/trailer.py

COPY trailer.xsl /usr/bin/trailer.xsl

COPY xsltransformer.py /usr/bin/xsltransformer.py

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/bin/trailer.py /usr/bin/xsltransformer.py /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

