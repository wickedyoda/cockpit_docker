# Cockpit Docker Image

This repository contains a Dockerfile for running **Cockpit** inside a container. Cockpit is an interactive web-based interface for administering GNU/Linux servers. It presents a friendly dashboard where you can inspect the system's health and make changes in real time.

Cockpit aims to "simplify complex tasks" by exposing the same controls that you would normally operate on the command line. Typical tasks include:

* Monitoring system resources and inspecting logs
* Managing services and containers
* Configuring storage and network settings
* Administering virtual machines
* Installing software updates
* Viewing and diagnosing system logs

The upstream project is hosted at [cockpit-project/cockpit](https://github.com/cockpit-project/cockpit). Cockpit runs in a real Linux login session and integrates smoothly with command line tools. Any action taken in the browser is immediately visible on the terminal, and vice versa.

## Image contents

The provided Dockerfile installs Cockpit on top of the Debian **stable-slim** base image and includes many optional modules, including:

* `cockpit-storaged` – manage disks and filesystems
* `cockpit-networkmanager` – configure networking
* `cockpit-packagekit` – perform package updates
* `cockpit-machines` – administer virtual machines
* `cockpit-podman` – manage Podman containers
* `cockpit-sosreport` – gather troubleshooting information
* `cockpit-pcp` – performance metrics collection

A dynamic user is created at build time with sudo privileges. The username and password are set via environment variables (`COCKPIT_USER` and `COCKPIT_PASSWORD`). These can be provided in a `.env` file which looks like:

```env
COCKPIT_USER=enter_name
COCKPIT_PASSWORD=changeme
```

## Building the image

Run the following command from the repository root. The Dockerfile is named `dockerfile` so we pass `-f` to specify it:

```bash
docker build -t my-cockpit -f dockerfile .
```

The Docker build temporarily installs a `policy-rc.d` script to prevent services
like `pcp` from starting during installation. This avoids errors when building
without systemd running and is cleaned up before the image is finalized.

You can customize the username and password at build time by passing build arguments:

```bash
docker build -t my-cockpit \
  --build-arg COCKPIT_USER=alice \
  --build-arg COCKPIT_PASSWORD=secret \
  -f dockerfile .
```

## Running the container

Once built, start Cockpit with:

```bash
docker run -d \
  --name cockpit \
  --env-file .env \
  -p 9090:9090 \
  my-cockpit
```

Then browse to <https://localhost:9090> and log in with the credentials from your `.env` file. Multiple hosts with Cockpit installed can be added from the web interface via SSH.

## License

This project is distributed under the terms of the [GNU General Public License v3.0](LICENSE).
