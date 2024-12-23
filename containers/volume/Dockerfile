# Use an official Debian base image
FROM debian:latest AS builder

# Perform root operations (e.g., apt update and package installations)
RUN apt-get update && apt-get upgrade -y

# Create a non-root user with a specific UID and GID
RUN useradd -u 1000 -m -s /bin/bash pi5ha

# Create a new stage to switch to the non-root user
FROM debian:latest

# Copy the updated filesystem from the builder stage
COPY --from=builder / /

# Set the working directory
WORKDIR /app

# Create the directory for the volume and set appropriate permissions
RUN mkdir -p /data && chown -R 1000:1000 /data

# Create the directory for the volume and set appropriate permissions
RUN chown -R 1000:1000 /app

# Copy the startup script into the container
COPY startup.sh /app/startup.sh

# Make the script executable
RUN chmod +x /app/startup.sh

RUN chown 1000:1000 /app/startup.sh

# Switch to the non-root user
USER pi5ha

# Command to run the script on container startup
CMD ["/app/startup.sh"]
