FROM ghcr.io/ponylang/ponyc:release-alpine AS build

WORKDIR /src/credo

COPY Makefile VERSION corral.json /src/credo/

WORKDIR /src/credo/credo

COPY credo /src/credo/credo/

WORKDIR /src/credo

RUN make arch=x86-64 static=true linker=bfd config=release \
 && make install

FROM scratch

LABEL org.opencontainers.image.source="https://github.com/seantallen-org/credo"

COPY --from=build /usr/local/bin/credo /usr/local/bin/credo
COPY LICENSE /

ENTRYPOINT ["/usr/local/bin/credo"]
