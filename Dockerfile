FROM ubuntu:latest
LABEL maintainer="Greg Farr"

RUN apt-get update && \
    apt-get install -y git

CMD ["/usr/bin/git"]
