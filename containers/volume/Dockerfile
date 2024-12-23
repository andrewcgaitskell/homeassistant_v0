# Use Alpine Linux as the base image
FROM alpine:latest

# Set a working directory inside the container
WORKDIR /app

# Copy the startup script into the container
COPY test_volume_permissions.sh /app/test_volume_permissions.sh

# Make the script executable
RUN chmod +x /app/test_volume_permissions.sh

# Mount a volume at /data and run the script during startup
CMD ["/app/test_volume_permissions.sh"]
