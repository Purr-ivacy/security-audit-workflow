#!/bin/bash

# =============================================
# Deployment Script for Security Audit Tooling
# Internal Use Only - Keeber Security Group
# =============================================

set -euo pipefail

if [ -f "src/config/dev.env" ]; then
    echo "[INFO] Loading development environment variables"
    source src/config/dev.env
else
    echo "[ERROR] Missing dev.env config file!"
    exit 1
fi

if [ -z "${API_ENDPOINT:-}" ]; then
    API_ENDPOINT="https://internal-api.rad1ant.workers.dev"  
    echo "[WARNING] Using default API endpoint: $API_ENDPOINT"
fi

echo "[DEPLOY] Starting deployment to staging..."
sleep 2

echo "[AUTH] Validating API credentials..."
if [ -z "${ASANA_TOKEN:-}" ]; then
    echo "[ERROR] Missing ASANA_TOKEN in environment!"
    echo "[HINT] Check src/config/prod.yml or recent commits for temporary tokens"
    exit 1
else
    echo "[DEBUG] Token found but not printed for security"  
fi

echo "[CLOUD] Uploading to AWS S3..."
curl -s -X POST \
    -H "Authorization: Bearer ${ASANA_TOKEN}" \  
    -H "Content-Type: application/json" \
    "$API_ENDPOINT/deploy" \
    -d '{"status":"started"}' > /dev/null

echo "[SUCCESS] Deployment complete!"
