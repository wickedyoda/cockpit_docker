# Use the official Debian base image
FROM debian:latest

# Set the working directory
WORKDIR /app

# Expose port 9090
EXPOSE 9090

# (Optional) Update package lists and install any additional packages
# RUN apt-get update && apt-get install -y <package_name>
apt-get update
apt-get upgrade -y

# Installing cockpit and plugins
apt-get install cockpit -y

# Installing optional plugins
apt-get install cockpit-storaged \
cockpit-networkmanager \
cockpit-packagekit \
cockpit-ostree \
cockpit-machines \
cockpit-podman \
cockpit-kdump \ 
cockpit-certificates \
cockpit-sosreport \
cockpit-pcp \
cockpit-sensors \
cockpit-tailscale 

# (Optional) Add your custom configurations or scripts
# COPY ./custom-config /app/custom-config

# Command to run when the container starts
CMD ["/bin/bash"]