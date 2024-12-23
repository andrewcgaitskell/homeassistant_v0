# Use Alpine Linux as the base image
FROM alpine:latest

# Set a working directory inside the container
WORKDIR /app

# Copy the startup script into the container
COPY startup.sh /app/startup.sh

# Make the script executable
RUN chmod +x /app/startup.sh

# Mount a volume at /data and run the script during startup
CMD ["/app/startup.sh"]
