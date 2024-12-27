# Base image from Espressif
FROM espressif/idf:latest

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    git \
    g++ \
    python3-pip \
    python3-dev \
    libssl-dev \
    libffi-dev \
    build-essential \
    libdbus-1-dev \
    libavahi-client-dev \
    libavahi-common-dev \
    libudev-dev \
    libglib2.0-dev \
    libusb-1.0-0-dev \
    && apt-get clean

# Upgrade pip and setuptools
RUN python3 -m pip install --upgrade pip setuptools

# Install Python dependencies for Matter
RUN pip3 install pycryptodome cryptography chip-device-ctrl

# Clone ESP-Matter repository
RUN git clone --recursive https://github.com/espressif/esp-matter.git /opt/esp/esp-matter

# Clone and build OpenThread
RUN git clone --recursive https://github.com/openthread/openthread.git /opt/esp/openthread
WORKDIR /opt/esp/openthread
RUN ./script/bootstrap && ./script/build

# Clone and build Matter chip-tool
RUN git clone --recursive https://github.com/project-chip/connectedhomeip.git /opt/esp/chip
WORKDIR /opt/esp/chip
RUN ./scripts/build/build_examples.py --target esp32

# Configure ESP-Matter
WORKDIR /opt/esp/esp-matter
RUN idf.py set-target esp32c6

# Set default working directory
WORKDIR /project
