# Local Setup — Helm Charts Ecommerce

This guide explains how to run the **orders-service** and **payments-service** locally on Kubernetes using **Helm**, **Tilt**, and **NGINX Ingress**.

---

## Prerequisites

Make sure you have the following installed:

- **Docker** or **Rancher Desktop** (with Kubernetes enabled)
- **kubectl** (v1.30+)
- **Helm** (v3+)
- **Tilt** (for live rebuilds)
- **NGINX Ingress Controller**

Install the ingress controller:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

## Run Locally
**1. Clone the repository**
```bash
git clone https://github.com/<your-org>/helm-charts-ecommerce.git
cd helm-charts-ecommerce
```
**2. Start Tilt**
```bash
tilt up 
```
**3. Verify Deployment**
```bash
kubectl get pods
kubectl get svc
kubectl get ingress 
```

## Configure Ingress
**1. Update /etc/hosts/:**
```
127.0.0.1 ecommerce.local
```
**2. Verify Ingress:**
```bash
kubectl get ingress
```

## Clean Up
```bash
tilt down
kubectl delete all --all
kubectl delete ns ingress-nginx
```
