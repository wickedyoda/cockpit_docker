# Use the official Debian slim base image
FROM debian:stable-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV COCKPIT_USER=${COCKPIT_USER}
ENV COCKPIT_PASSWORD=${COCKPIT_PASSWORD}

# Set the working directory
WORKDIR /app

# Expose Cockpit port
EXPOSE 9090

# Install Cockpit and required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl gnupg systemd systemd-sysv dbus sudo passwd \
                       cockpit \
                       cockpit-storaged \
                       cockpit-networkmanager \
                       cockpit-packagekit \
                       cockpit-machines \
                       cockpit-podman \
                       cockpit-sosreport \
                       cockpit-pcp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create dynamic user with sudo privileges
RUN useradd -m -s /bin/bash "$COCKPIT_USER" && \
    echo "$COCKPIT_USER:$COCKPIT_PASSWORD" | chpasswd && \
    usermod -aG sudo "$COCKPIT_USER" && \
    echo "$COCKPIT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Enable systemd inside the container
STOPSIGNAL SIGRTMIN+3

CMD ["/lib/systemd/systemd"]