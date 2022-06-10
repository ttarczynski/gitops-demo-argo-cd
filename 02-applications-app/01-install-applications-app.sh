#!/bin/bash

# 01) Create argocd app:
kubectl create ns argo-applications

argocd app create 00-argo-applications \
  --repo https://github.com/ttarczynski/gitops-demo-argo-cd.git \
  --path manifests/00-argo-applications \
  --directory-recurse \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace guestbook \
  --sync-policy automated \
  --self-heal \
  --sync-option Prune=true
