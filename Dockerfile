FROM debian:stable-slim

RUN apt update

RUN apt install -y apt-utils &&  apt -y upgrade 

RUN apt install -y  \
	xorg \
	xinit x11-xserver-utils \
  xterm dbus-x11 xserver-xorg-input-libinput \
  xserver-xorg-video-intel xfonts-base \
	xbase-clients xserver-xorg-legacy \
	dkms

RUN apt install -y \
	git \
	cmake \
	llvm \
	clang \
	qt6-3d-dev \
	qt6-base-dev \
	libzip-dev \
	librust-vcpkg-dev \
  libhdf5-openmpi-dev \
	libopenmpi-dev \
	libheif-dev

RUN apt install -y \
	gfortran gfortran-13 \
	gfortran-13-x86-64-linux-gnu gfortran-x86-64-linux-gnu \
	glib-networking glib-networking-common glib-networking-services \
	libbz2-dev \
 	mesa-va-drivers mesa-vdpau-drivers modemmanager mpi-default-bin \
	mpi-default-dev \
	autoconf automake autotools-dev

ENV DISPLAY=:0


ENV LANGUAGE=en_GB:en
ENV LANG=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8

RUN apt install -y  locales


#RUN update-locale LANG=en_GB.UTF-8
RUN update-locale

RUN mkdir -p /root/.config
RUN mkdir -p /root/Downloads
RUN mkdir -p /root/slicing
RUN mkdir -p /run/user/1000

ENV XDG_RUNTIME_DIR=/run/user/1000

WORKDIR /usr/src


RUN apt -y install \
	build-essential \
	cmake \
	cmake-curses-gui \
	mesa-common-dev \
	mesa-utils \
	freeglut3-dev \
	ninja-build \
	qt6-declarative-dev \
	libxkbcommon-dev \
	zipcmp \
	zipmerge \
	ziptool \
	wget


RUN git clone https://github.com/Kitware/VTK.git

WORKDIR VTK

RUN mkdir build

WORKDIR build

RUN cmake .. -DVTK_GROUP_ENABLE_Qt=YES -DVTK_USE_MPI=YES

RUN make -j2 
RUN make install

WORKDIR /usr/src

RUN wget https://github.com/3MFConsortium/lib3mf/releases/download/v2.4.1/lib3mf-2.4.1-Linux.deb

RUN apt -y install ./lib3mf-2.4.1-Linux.deb

RUN git clone https://github.com/vivaaprimavera/Strecs3D.git

WORKDIR Strecs3D

RUN mkdir build

WORKDIR build

RUN cmake .. && make

RUN apt -y install python3-pip \
	python3-pip-whl \
	binutils \
	coreutils \
	desktop-file-utils \
	fakeroot \
	fuse \
	patchelf \
	python3-setuptools \
	squashfs-tools \
	strace \
	util-linux \
	zsync
