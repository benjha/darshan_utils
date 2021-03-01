
FROM fedora:29 as build

ARG DARSHAN_VER=3.1.6

# We specify gcc and make dependencies because we will uninstall them after
# the compilation of darshan. Make sure they are the latest packages installed.
RUN apt update
RUN dnf install -y \
        gcc \
            libgcc libxcrypt binutils cpp kernel-headers libgomp glibc-devel \
            glibc-headers info isl libmpc libpkgconf pkgconf pkgconf-m4      \
            libxcrypt-devel pkgconf-pkg-config                               \
        make \
            gc guile libatomic_ops libtool-ltdl \
        texlive-latex texlive-epstopdf perl-Pod-LaTeX perl-HTML-Parser \
        bzip2 zlib zlib-devel \
    && curl -O ftp://ftp.mcs.anl.gov/pub/darshan/releases/darshan-$DARSHAN_VER.tar.gz \
    && tar -xf darshan-$DARSHAN_VER.tar.gz && cd darshan-$DARSHAN_VER/darshan-util/ \
    && ./configure --prefix=/usr/local/darshan-$DARSHAN_VER --with-zlib \
    && make -j \
    && make install
