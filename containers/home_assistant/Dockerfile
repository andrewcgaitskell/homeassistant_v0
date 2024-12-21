# Use the latest Python 3.12 slim image
FROM python:3.12-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    git \
    && apt-get clean

# Set working directory
WORKDIR /usr/src/homeassistant

# Copy requirements.txt to the container
COPY requirements.txt requirements.txt

# Create a Python virtual environment
RUN python -m venv venv

# Activate the virtual environment and install dependencies from requirements.txt
RUN . ./venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# Expose the default port used by Home Assistant
EXPOSE 8123

# Create a volume for persistent configuration
VOLUME ["/config"]

# Set the entry point to activate the virtual environment and start Home Assistant
CMD ["/usr/src/homeassistant/venv/bin/hass", "--config", "/config"]
