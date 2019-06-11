FROM busybox:latest
LABEL maintainer="Greg Farr"

RUN apt-get update && \
    apt-get install git

CMD ["/usr/bin/git"]
