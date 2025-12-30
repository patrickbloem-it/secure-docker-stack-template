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
