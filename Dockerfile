FROM centos:7

# install build-essential
# RUN yum install gcc gcc-c++ gcc.x86_64 gcc-c__.x86_64 -y
RUN yum install gcc.x86_64 gcc-c++.x86_64 wget.x86_64 bzip2-devel.x86_64 pkgconfig.x86_64 openssl-devel.x86_64 make.x86_64 man.x86_64 nasm.x86_64 gmp.x86_64 gdbm-devel.x86_64 readline-devel.x86_64 compat-readline43.x86_64 ncurses-devel.x86_64 db4-devel.x86_64 automake* autoconf* kernel-devel kernel-headers openssl-devel wget gcc gcc-c++ clang ld-linux.so.2 libXtst libXt mesa-libGL-devel mesa-libGLU-devel libX11-devel libXmu freeglut -y
RUN yum groupinstall "Development Tools" -y

# install cmake
RUN yum install wget -y
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2.tar.gz
RUN tar xvf cmake-3.18.2.tar.gz
RUN cd cmake-3.18.2 && \
        ./bootstrap --prefix=/usr/local && \
        make && \
        make install

# install git
RUN rpm -Uvh http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
RUN yum --enablerepo=WANdisco-git --disablerepo=base,updates info git
RUN yum install git -y

# install vcpkg
RUN mkdir /opt/app
RUN git clone https://github.com/microsoft/vcpkg.git /opt/app/vcpkg

# vcpkg dependency
RUN yum install curl zip unzip tar -y
RUN /opt/app/vcpkg/bootstrap-vcpkg.sh

# install physx
RUN /opt/app/vcpkg/vcpkg install physx

# Add contents
ADD src home/src
WORKDIR home/src

