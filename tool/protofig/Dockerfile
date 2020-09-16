FROM docker.io/library/golang:1.14-buster as protofig_builder
ENV CGO_ENABLED 0
ENV FLUTTER_URL "https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_1.18.0-11.1.pre-beta.tar.xz"
RUN mkdir -p /core-runtime
COPY . /core-runtime
WORKDIR /core-runtime
RUN ls /core-runtime

# GET DEPENDENCIES
RUN apt update
RUN apt install -y protobuf-compiler libprotobuf-dev make git wget curl tar unzip xz-utils tree

# CREATE GO dirs
RUN mkdir -p /go/{bin,src}
# ENVS
ENV GOPATH /go
ENV FLUTTERPATH /flutter/flutter
ENV PATH /root/.pub-cache/bin:${HOME}/.pub-cache/bin:${GOPATH}/bin:${FLUTTERPATH}/bin:${FLUTTERPATH}/bin/cache/dart-sdk/bin:${PATH}

# FLUTTER
RUN mkdir -p /flutter && cd / && \
    wget -O /flutter/flutter.tar.xz  ${FLUTTER_URL} && \
    cd /flutter && tar -xf flutter.tar.xz

# ACTIVATE PROTOC PLUGINS
RUN go get -u -v google.golang.org/protobuf/cmd/protoc-gen-go && \
    /flutter/flutter/bin/cache/dart-sdk/bin/pub global activate protoc_plugin
RUN cp $HOME/.pub-cache/bin/protoc-gen-dart /usr/local/bin/protoc-gen-dart
## BUILD THE TOOL
RUN cd /core-runtime/tool/protofig/protoc-gen-configdef && make this-build
RUN cd /core-runtime/tool/protofig && make this-build-all
#
## BUILD DOCKER / PODMAN IMAGE
FROM docker.io/library/debian:buster-slim
COPY --from=protofig_builder /go/bin/bs-protofig /protofig/bs-protofig
WORKDIR /protofig
CMD /protofig/bs-protofig

LABEL org.opencontainers.image.title="bs-protofig" \
    org.opencontainers.image.authors="getcouragenow" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="getcouragenow"
