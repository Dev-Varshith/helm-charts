#!/bin/bash
set -e

echo "🔄 Starting ingress-nginx setup..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

echo "⏳ Waiting for ingress controller to appear..."
for i in {1..10}; do
  PODS=$(kubectl get pods -n ingress-nginx 2>/dev/null | grep ingress-nginx-controller || true)
  if [ -n "$PODS" ]; then
    echo "✅ Found ingress-nginx pods!"
    break
  fi
  echo "⏳ Pods not found yet... retrying ($i/10)"
  sleep 5
done

echo "⏳ Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s || {
    echo "⚠️ Ingress controller not ready in time"
    exit 1
  }

echo "✅ Ingress-nginx ready!"
