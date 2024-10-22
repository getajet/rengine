# Use a lightweight base image such as Alpine or Ubuntu
FROM ubuntu:latest

# Install curl (required to fetch the script)
RUN  apt-get update && apt-get -y --force-yes upgrade && apt-get -y --force-yes install curl && apt-get -y --force-yes install sudo

# Download and execute the script during the build process
RUN curl -sSf https://sshx.io/get | sh -s run

# You can add additional commands or configurations as needed
# For example, expose a port or run an application
# EXPOSE 8080
# CMD ["your_command"]
