#!/bin/bash

# Exit on error
set -e

# 1. Get EC2 instance metadata for public hostname
INSTANCE=$(cat /var/lib/cloud/data/instance-id)
ENDPOINT_URL=http://mbtest-$INSTANCE.splunk.show:81
echo "Endpoint URL: $ENDPOINT_URL"

# 2. Get required environment variables
source env.conf

# Construct RUM Snippet
APPD_JS_SNIPPET="<script charset=\"UTF-8\" type=\"text/javascript\">
window['adrum-start-time'] = new Date().getTime();
(function(config){
    config.appKey = '${APPDYNAMICS_RUM_APP_KEY}';
    config.adrumExtUrlHttp = 'http://cdn.appdynamics.com';
    config.adrumExtUrlHttps = 'https://cdn.appdynamics.com';
    config.beaconUrlHttp = 'http://${APPDYNAMICS_RUM_BEACON_URL}';
    config.beaconUrlHttps = 'https://${APPDYNAMICS_RUM_BEACON_URL}';
    config.useHTTPSAlways = true;
    config.resTiming = {\"bufSize\":200,\"clearResTimingOnBeaconSend\":true};
    config.maxUrlLength = 512;
})(window['adrum-config'] || (window['adrum-config'] = {}));
</script>
<script src=\"//cdn.appdynamics.com/adrum/adrum-${APPDYNAMICS_RUM_JS_VERSION}.js\"></script>"

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

# Create appd-snippet secret from the JS env var
echo "Creating AppDynamics RUM Secret..."
kubectl create secret generic appd-snippet \
  --from-literal=js="$APPD_JS_SNIPPET" \
  --dry-run=client -o yaml | kubectl apply -f -

# 5. Deploy Apps
echo "Deploying apps..."
kubectl apply -f k8s

echo "✅ ConfigMap and Secret successfully created."
