FROM busybox:glibc
LABEL maintainer="Greg Farr"

RUN apt update && \
    apt install git

CMD ["/usr/bin/git"]
