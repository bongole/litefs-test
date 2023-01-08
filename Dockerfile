FROM ubuntu:22.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends fuse tzdata curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=flyio/litefs:0.3 /usr/local/bin/litefs /usr/local/bin/litefs
