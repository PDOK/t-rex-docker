# build t-rex
FROM osgeo/gdal:ubuntu-full-3.4.2 as trex-builder
RUN apt-get -y update && apt-get install -y \
    curl \
    make \
    gnupg2 \
    pkg-config \
    openssl \
    libssl-dev
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG trex_release="v0.14.3.tar.gz"

RUN apt-get update && apt-get install -y libgdal-dev
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
RUN echo "export PATH=~/.cargo/bin:$PATH" >> ~/.bashrc
# RUN curl -sSfL "https://github.com/t-rex-tileserver/t-rex/archive/${trex_release}" | tar xzf -
RUN curl -sSfL "https://github.com/PDOK/t-rex/archive/refs/heads/gdal-open-options.tar.gz" | tar xzf -
RUN mv *t-rex* t-rex
RUN cd t-rex && cargo build --release

# actual image
FROM osgeo/gdal:ubuntu-full-3.4.2
ENV TZ Europe/Amsterdam
LABEL MAINTAINER="pdok@kadaster.nl"

RUN apt-get -y update && apt-get install -y \
    curl \
    gnupg2

COPY --from=trex-builder /t-rex/target/release/t_rex /usr/local/bin
RUN ln -s /usr/lib/libgdal.so /usr/lib/libgdal.so.26

EXPOSE 6767
ENTRYPOINT ["/usr/local/bin/t_rex"]
