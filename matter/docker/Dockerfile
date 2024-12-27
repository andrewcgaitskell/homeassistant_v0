# Base ESP-IDF image
FROM espressif/idf:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    libssl-dev \
    libffi-dev \
    build-essential \
    cmake \
    ninja-build \
    git \
    g++ \
    && apt-get clean

# Upgrade pip and setuptools
RUN python3 -m pip install --upgrade pip setuptools

# Clone ESP-Matter repository
RUN git clone --recursive https://github.com/espressif/esp-matter.git /opt/esp/esp-matter

# Install ESP-IDF dependencies for Matter
WORKDIR /opt/esp/esp-matter
RUN idf.py set-target esp32c6 && idf.py build

# Set default working directory
WORKDIR /project
