# Laboratorio 8.- CI/CD

## Introducción

```bash
Utilizar el laboratorio 6 de la asignatura.

Crear repositorio en github para el proyecto (AS-Laboratorio8)
```

## Configuración inicial del workflow

```yaml
name: CI/CD
on:
  push:
    branches: 
      - main
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Download Repository
        uses: actions/checkout@v4
      - name: Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: ./app
          push: true
          tags: xabierland/as-laboratorio-8-web:latest
      - name: Login to Google Cloud Compute
        uses: google-github-actions/auth@v1
        with:
          credentials_json: ${{ secrets.GCC_TOKEN }}
          project_id: ${{ secrets.GCC_NAME }}
      - name: Autenticate to Kubernetes Engine
        uses: simenandre/setup-gke-gcloud-auth-plugin@v1
      - name: Configure kubectl
        uses: google-github-actions/get-gke-credentials@v1
        with:
          cluster_name: lab8-cluster
          location: us-central1
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f ./k8s/web-deployment.yaml
          kubectl apply -f ./k8s/sgbd-deployment.yaml
          kubectl apply -f ./k8s/web-service.yaml
          kubectl apply -f ./k8s/sgbd-service.yaml
          kubectl apply -f ./k8s/ingress.yaml
          kubectl rollout restart deployment web-d
          kubectl rollout restart deployment sgbd-d
```

## Nuevo Workflow para pruebas

```bash

```
