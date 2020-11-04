#build image
FROM alpine:3.7

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ARG UPX_VERSION=3.96

RUN apk add --no-cache --virtual .build-deps curl xz && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/* && \
    curl -fsSL -o /tmp/upx-${UPX_VERSION}-amd64_linux.tar.xz https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz && \
    xz -d -v /tmp/upx-${UPX_VERSION}-amd64_linux.tar.xz

# run image
FROM lalyos/scratch-chmx

COPY --from=0 /tmp/upx /bin/upx

ENV LANG C.UTF-8

RUN ["/bin/chmx", "/bin/upx"]

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/bin/upx"]
