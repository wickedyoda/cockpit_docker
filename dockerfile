# Use the official Debian base image
FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

# Environment variables for the cockpit admin user
ENV COCKPIT_USER=cockpitadmin \
    COCKPIT_PASSWORD=secret

# Install Cockpit and all plugin packages, along with sudo
RUN apt-get update && \
    apt-get install -y sudo \
        cockpit cockpit-389-ds cockpit-bridge cockpit-doc \
        cockpit-machines cockpit-networkmanager cockpit-packagekit \
        cockpit-pcp cockpit-podman cockpit-sosreport cockpit-storaged \
        cockpit-system cockpit-tests cockpit-ws && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a user for Cockpit with sudo privileges
RUN useradd -m -s /bin/bash $COCKPIT_USER && \
    echo "$COCKPIT_USER:$COCKPIT_PASSWORD" | chpasswd && \
    usermod -aG sudo $COCKPIT_USER

# Cockpit listens on port 9090
EXPOSE 9090

# Start the Cockpit web service
CMD ["/usr/libexec/cockpit-ws"]
