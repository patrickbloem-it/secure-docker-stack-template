#!/bin/bash

echo "Initializing Secure Docker Stack Template..."

# Define directories
DIRS=(
  "./logs/traefik"
  "./crowdsec/db"
  "./crowdsec/config"
  "./traefik"
)

# Create directories
for d in "${DIRS[@]}"; do
  if [ ! -d "$d" ]; then
    echo "Creating directory: $d"
    mkdir -p "$d"
  else
    echo "Directory exists: $d"
  fi
done

# Create ACME JSON file with strict permissions (Required by Traefik)
ACME_FILE="./traefik/acme.json"
if [ ! -f "$ACME_FILE" ]; then
    echo "Creating empty acme.json..."
    touch "$ACME_FILE"
    chmod 600 "$ACME_FILE"
    echo "Permissions set to 600 for acme.json"
else
    echo "acme.json already exists. Ensuring permissions..."
    chmod 600 "$ACME_FILE"
fi

# Create basic CrowdSec acquisition config if not exists
ACQUIS_FILE="./crowdsec/acquis.yaml"
if [ ! -f "$ACQUIS_FILE" ]; then
    echo "Creating default CrowdSec acquisition config..."
    cat <<EOF > "$ACQUIS_FILE"
filenames:
  - /var/log/traefik/access.log
labels:
  type: traefik
EOF
fi

echo "Initialization complete. Please configure .env before starting."
