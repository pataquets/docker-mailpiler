FROM gcc

# Warning: WIP
# http://www.mailpiler.org/wiki/current:installation

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      libtre-dev \
      libwrap0-dev \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  mkdir -vp /var/piler/ && \
  groupadd piler && \
  useradd -g piler -s /bin/sh -d /var/piler piler && \
  usermod -L piler && \
  chmod 755 /var/piler

ADD src/ /usr/src/myapp
WORKDIR /usr/src/myapp
RUN \
  ./configure \
    --localstatedir=/var \
    --with-database=mysql \
    --enable-tcpwrappers \
    --enable-starttls

RUN make
