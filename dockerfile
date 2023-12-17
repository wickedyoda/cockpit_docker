# Use the official Debian base image
FROM debian:stable-slim

# Set the working directory
WORKDIR /app

# Expose port 9090
EXPOSE 9090

# Adduser
# RUN adduser traver


# Update package lists, upgrade, and install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cockpit \
                       cockpit-storaged \
                       cockpit-networkmanager \
                       cockpit-packagekit \
                       cockpit-machines \
                       cockpit-podman \
                       cockpit-sosreport \
                       cockpit-pcp
