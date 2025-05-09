#!/bin/bash

# Exit on error
set -e

# 1. Get EC2 instance metadata for public hostname
INSTANCE=$(cat /var/lib/cloud/data/instance-id)
ENDPOINT_URL=http://conf-$INSTANCE:81
echo "Endpoint URL: $ENDPOINT_URL"

# 2. Get required environment variables
source env.conf

# 3. Create ConfigMap
echo "Creating ConfigMap..."
kubectl create configmap appd-config \
  --from-literal=APPDYNAMICS_AGENT_ACCOUNT_NAME="$APPDYNAMICS_AGENT_ACCOUNT_NAME" \
  --from-literal=APPDYNAMICS_CONTROLLER_HOST_NAME="$APPDYNAMICS_CONTROLLER_HOST_NAME" \
  --from-literal=APPDYNAMICS_AGENT_APPLICATION_NAME="$APPDYNAMICS_AGENT_APPLICATION_NAME" \
  --from-literal=ENDPOINT_URL="$ENDPOINT_URL" \
  --dry-run=client -o yaml | kubectl apply -f -

# 4. Create Secret
echo "Creating Secret..."
kubectl create secret generic appd-secret \
  --from-literal=APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY="$APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ ConfigMap and Secret successfully created."
