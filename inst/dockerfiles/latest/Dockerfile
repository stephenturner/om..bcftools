FROM debian:10

# Set version number, easy to update later
ARG BCFTOOLSVERSION="1.14"

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    autoconf \
    automake \
    bzip2 \
    ca-certificates \
    g++ \
    gcc \
    libbz2-dev \
    libcurl4-openssl-dev \
    libgsl0-dev \
    liblzma-dev \
    libssl-dev \
    make \
    ncurses-dev \
    wget \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && apt-get autoclean

# Convenience aliases in case stepping inside container (docker run --rm -it <tag> /bin/bash)
RUN alias l="ls -lhgGop --color=always"
RUN alias u="cd ..; l"

# Install bcftools (version noted above)
RUN wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLSVERSION}/bcftools-${BCFTOOLSVERSION}.tar.bz2 && \
 tar -vxjf bcftools-${BCFTOOLSVERSION}.tar.bz2 && \
 rm bcftools-${BCFTOOLSVERSION}.tar.bz2 && \
 cd bcftools-${BCFTOOLSVERSION} && \
 make && \
 make install

# Outsider requires /working_dir
RUN mkdir /working_dir
WORKDIR /working_dir
