#build image
FROM alpine:3.7

ARG UPX_VERSION=3.96
ENV LANG C.UTF-8

RUN apk add --no-cache --virtual .build-deps curl xz && \
    curl -fsSL -o /tmp/upx-amd64_linux.tar.xz https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz && \
    tar -xvf /tmp/upx-amd64_linux.tar.xz && \
    pwd


# run image
FROM lalyos/scratch-chmx

ARG UPX_VERSION=3.96
COPY --from=0 /upx-${UPX_VERSION}-amd64_linux/upx /bin/upx

ENV LANG C.UTF-8

RUN ["/bin/chmx", "/bin/upx"]

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/bin/upx"]
