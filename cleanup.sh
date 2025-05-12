#!/bin/bash

echo "Deleting ConfigMap and Secret..."

kubectl delete configmap appd-config --ignore-not-found
kubectl delete secret appd-secret --ignore-not-found
kubectl delete secret appd-snippet --ignore-not-found
kubectl delete -f k8s
echo "✅ Cleanup complete."
