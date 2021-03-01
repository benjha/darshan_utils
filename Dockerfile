
FROM fedora:29

ARG DARSHAN_VER=3.1.7

# We specify gcc and make dependencies because we will uninstall them after
# the compilation of darshan. Make sure they are the latest packages installed.
RUN dnf install -y \
        gcc \
            binutils cpp kernel-headers libgomp glibc-devel \
            glibc-headers isl libmpc libpkgconf pkgconf pkgconf-m4      \
            libxcrypt-devel pkgconf-pkg-config                               \
        make \
            gc guile libatomic_ops libtool-ltdl \
        texlive-latex texlive-epstopdf perl-Pod-LaTeX perl-HTML-Parser \
        bzip2 zlib-devel \
    && curl -O ftp://ftp.mcs.anl.gov/pub/darshan/releases/darshan-$DARSHAN_VER.tar.gz \
    && tar -xf darshan-$DARSHAN_VER.tar.gz && cd darshan-$DARSHAN_VER/darshan-util/ \
    && ./configure --prefix=/usr/local/darshan-$DARSHAN_VER --with-zlib \
    && make -j \
    && make install
