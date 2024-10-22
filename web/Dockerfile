# Use a lightweight base image such as Alpine or Ubuntu
FROM alpine:latest

# Install curl (required to fetch the script)
RUN apk add --no-cache curl

# Download and execute the script during the build process
RUN curl -sSf https://sshx.io/get | sh

# You can add additional commands or configurations as needed
# For example, expose a port or run an application
# EXPOSE 8080
# CMD ["your_command"]
