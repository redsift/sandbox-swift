FROM quay.io/vchris1416/sandbox:ubuntu16.10
MAINTAINER Christos Vontas email: christos@redsift.io version: 1.0.0

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends git cmake ninja-build clang uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

LABEL io.redsift.sandbox.install="/usr/bin/redsift/install" io.redsift.sandbox.run="/usr/bin/redsift/run"

RUN mkdir swift-source && cd swift-source && \
    curl -fSsL https://swift.org/builds/swift-3.1.1-release/ubuntu1610/swift-3.1.1-RELEASE/swift-3.1.1-RELEASE-ubuntu16.10.tar.gz -o swift.tar.gz && \
    tar xzf swift.tar.gz --directory / --strip-components=1 && \
    cd .. && rm -rf swift-source && swift --version

COPY root /

COPY Sources /tmp/sandbox/Sources
COPY Tests /tmp/sandbox/Tests
COPY Package.swift /tmp/sandbox
COPY TestFixtures /tmp/sandbox/TestFixtures

WORKDIR /tmp/sandbox

# ENV SWIFT_SOURCES_LOCATION /tmp/sandbox

RUN swift test && swift build -c release && \
    cp -R /tmp/sandbox/.build/release/* /usr/bin/redsift

WORKDIR /run/sandbox/sift

ENTRYPOINT ["/bin/bash"]
