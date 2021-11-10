FROM debian:10

# Set version number, easy to update later
ARG VERSION="1.14"

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    bzip2 \
    ca-certificates \
    gcc \
    libbz2-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    wget \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && apt-get autoclean

# Install bcftools
RUN wget https://github.com/samtools/bcftools/releases/download/${VERSION}/bcftools-${VERSION}.tar.bz2 && \
    tar -vxjf bcftools-${VERSION}.tar.bz2 && \
    rm bcftools-${VERSION}.tar.bz2 && \
    cd bcftools-${VERSION} && \
    make && \
    make install

# Install htslib (tabix and bgzip)
RUN wget https://github.com/samtools/htslib/releases/download/${VERSION}/htslib-${VERSION}.tar.bz2 && \
    tar -vxjf htslib-${VERSION}.tar.bz2 && \
    rm htslib-${VERSION}.tar.bz2 && \
    cd htslib-${VERSION} && \
    make && \
    make install

# Convenience aliases in case stepping inside container (docker run --rm -it <tag> /bin/bash)
RUN echo 'alias l="ls -lhgGop --color=always"' >> ~/.bashrc
RUN echo 'alias u="cd ..; l"' >> ~/.bashrc

# Outsider requires /working_dir
RUN mkdir /working_dir
WORKDIR /working_dir
