FROM busybox:latest
LABEL maintainer="Greg Farr"

RUN sudo apt-get update && \
    sudo apt-get install git

CMD ["/usr/bin/git"]
