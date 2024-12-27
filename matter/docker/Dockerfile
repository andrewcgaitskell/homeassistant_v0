# Start with the official ESP-IDF image
FROM espressif/idf:latest

# Set environment variables for ESP-IDF
ENV IDF_PATH=/opt/esp/idf
ENV PATH=$IDF_PATH/tools:$PATH

# Update and install necessary dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    git \
    g++ \
    python3-pip \
    libdbus-1-dev \
    libavahi-client-dev \
    libavahi-common-dev \
    libudev-dev \
    libglib2.0-dev \
    libusb-1.0-0-dev \
    && apt-get clean

# Install Python dependencies for Matter
RUN pip3 install \
    pycryptodome \
    cryptography \
    chip-device-ctrl \
    chip-tool

# Clone ESP-Matter repository
RUN git clone --recursive https://github.com/espressif/esp-matter.git /opt/esp/esp-matter

# Clone OpenThread and dependencies
RUN git clone --recursive https://github.com/openthread/openthread.git /opt/esp/openthread

# Build OpenThread CLI and libraries
WORKDIR /opt/esp/openthread
RUN ./script/bootstrap
RUN ./script/build

# Configure ESP-Matter
WORKDIR /opt/esp/esp-matter
RUN idf.py set-target esp32c6

# Make ESP-Matter accessible from mounted projects
ENV MATTER_PATH=/opt/esp/esp-matter
ENV PATH=$MATTER_PATH:$PATH

# Return to default work directory
WORKDIR /project
