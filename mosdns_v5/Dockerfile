FROM golang:1.19.2-alpine as unpack
WORKDIR /

RUN set -xe \
  && apk add --no-cache curl \
  && go install github.com/urlesistiana/v2dat@latest \
  && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
  && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
  && mkdir dat \
  && v2dat unpack geoip -o dat -f "private" geoip.dat \
  && v2dat unpack geoip -o dat -f "cn" geoip.dat \
  && v2dat unpack geosite -o dat -f "cn" geosite.dat \
  && v2dat unpack geosite -o dat -f "gfw" geosite.dat \
  && v2dat unpack geosite -o dat -f "category-ads-all" geosite.dat \
  && v2dat unpack geosite -o dat -f "geolocation-!cn" geosite.dat


FROM irinesistiana/mosdns:latest
LABEL maintainer="None"

COPY ./config.yaml /etc/mosdns/config.yaml
COPY ./dat_exec.yaml /etc/mosdns/dat_exec.yaml
COPY ./dns.yaml /etc/mosdns/dns.yaml
COPY ./entrypoint.sh /entrypoint.sh
COPY --from=unpack /dat /dat
RUN chmod a+x /entrypoint.sh

# RUN set -xe \
#   && apk add --no-cache curl \
#   && cd / \
#   && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
#   && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
#   && apk del curl
# # &&  echo '0 2 * * *  wget -O /geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat'>>/var/spool/cron/crontabs/root  \
# # &&  echo '0 2 * * *  wget -O /geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat'>>/var/spool/cron/crontabs/root  \
# # && apk del curl

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp
# CMD /usr/bin/mosdns start --dir /etc/mosdns

ENTRYPOINT [ "/entrypoint.sh" ]