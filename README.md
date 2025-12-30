# Secure Docker Stack Template (Traefik + CrowdSec)

## Overview
This repository provides a standardized, compliant boilerplate for deploying web services using Docker Compose. It focuses on infrastructure hardening, network segregation, and automated certificate management via Traefik.

The stack is designed for stability and adherence to common security baselines (e.g., BSI IT-Grundschutz principles regarding containerization and TLS termination). It is intended for use in public sector environments or SMEs requiring a low-maintenance, audit-friendly container infrastructure.

## Architecture & Features

*   **Reverse Proxy / Edge Router:** Traefik v3 handling automatic TLS (Let's Encrypt), strict headers, and traffic routing.
*   **Intrusion Prevention:** CrowdSec agent integrated for log parsing and automated IP remediation at the application layer.
*   **Network Segregation:** Strict separation of internal backend networks and public-facing frontend networks.
*   **Hardening:** 
    *   ReadOnly file systems where applicable.
    *   Dropped capabilities for container processes.
    *   Socket proxy to protect the Docker daemon socket.

## Prerequisites

*   Linux Host (Debian/Ubuntu LTS recommended)
*   Docker Engine & Docker Compose (plugin)
*   Public IPv4/IPv6 address
*   DNS A/AAAA records pointing to the host

## Installation & Usage

### 1. Clone Repository and Initialize
Run the initialization script to create necessary directory structures and set permission bits for the ACME storage.****
git clone https://github.com/patrick-bloem/secure-docker-stack-template.git
cd secure-docker-stack-template
chmod +x init.sh
./init.sh

text

### 2. Configuration
Copy the environment template and adjust variables.

cp .env.example .env
nano .env

text

**Required adjustments:**
*   `DOMAIN_NAME`: Your primary domain (e.g., `services.example.com`).
*   `ACME_EMAIL`: Email address for Let's Encrypt expiration notifications.

### 3. Deployment
Start the stack in detached mode.

docker compose up -d

text

### 4. Verification
Check container status and logs to ensure the proxy is binding to ports 80/443 correctly.

docker compose ps
docker compose logs -f traefik

text

## Security & Compliance Notes

*   **TLS Protocol:** Configured for TLS 1.2 and 1.3 only.
*   **Docker Socket:** The main Traefik container does not mount the raw Docker socket. A `socket-proxy` is recommended for production environments (configuration included in `docker-compose.yml` but commented out for simplicity in this template).
*   **Logs:** Logs are retained locally for CrowdSec analysis. Ensure log rotation is configured on the host system to prevent disk exhaustion.

## License
MIT License. Provided "as is" for educational and infrastructure template purposes.
