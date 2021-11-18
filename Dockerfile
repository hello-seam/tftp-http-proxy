FROM golang:1.17-bullseye AS build

COPY vendor/ /usr/src/tftp-http-proxy/vendor/
COPY Makefile main.go /usr/src/tftp-http-proxy/

WORKDIR /usr/src/tftp-http-proxy

ENV GO111MODULE=off
RUN make

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y dumb-init gosu libcap2-bin && apt-get clean

COPY entrypoint.sh /usr/sbin/entrypoint.sh
COPY --from=build /usr/src/tftp-http-proxy/dist/tftp-http-proxy /usr/bin/tftp-http-proxy

RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/tftp-http-proxy

ENTRYPOINT [ "/usr/sbin/entrypoint.sh" ]
