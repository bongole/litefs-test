FROM ubuntu:22.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends fuse tzdata curl ca-certificates sqlite3 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=flyio/litefs:0.3 /usr/local/bin/litefs /usr/local/bin/litefs

RUN useradd -u 1000 -s /bin/bash -o -m app

RUN rm -rf /litefs /var/lib/litefs \
    && mkdir -p /litefs /var/lib/litefs \
    && chown app:app /litefs /var/lib/litefs

WORKDIR /home/app
USER app

