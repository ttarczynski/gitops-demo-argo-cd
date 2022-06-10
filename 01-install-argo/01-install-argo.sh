#!/bin/bash


# 01) Install Argo-CD using Helm:
kubectl create ns argo-cd
helm repo add argo https://argoproj.github.io/argo-helm
#helm install --namespace argo-cd argo-cd argo/argo-cd
helm upgrade argo-cd argo/argo-cd --namespace argo-cd --install --values ./values.yaml

# 02) Install Argo-CD CLI
brew install argocd

# 03) Change password
kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
ARGO_SVC_IP="$(k get svc -n argo-cd argo-cd-argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
argocd login --insecure "$ARGO_SVC_IP"
argocd account update-password


# 04) Login in GUI
echo "$ARGO_SVC_IP"
# Open in browser: https://<ARGO_SVC_IP>/
