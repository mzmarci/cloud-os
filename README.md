# cloud-os

This can be defined as a production-grade Kubernetes platform for Cloud operating system using EKS, GitOps, observability, SLOs and reliability engineering.

A production-grade Kubernetes platform for Puter with SRE, observability, reliability engineering, GitOps, security, disaster recovery, and automated delivery.


# Project Architecture

GitHub
   │
   ├── CI (GitHub Actions)
   │       ├── lint
   │       ├── tests
   │       ├── docker build
   │       ├── trivy scan
   │       └── push image to ECR
   │
GitOps Repo
   │
ArgoCD
   │
EKS Cluster
   │
 ┌─────────────────────────┐
 │ Ingress Layer           │
 │ ALB + NGINX Ingress     │
 └─────────────────────────┘
             │
 ┌─────────────────────────┐
 │ Puter Application       │
 │ multiple services       │
 └─────────────────────────┘
             │
 ┌─────────────────────────┐
 │ Stateful Layer          │
 │ Redis / DB / Storage    │
 └─────────────────────────┘

Observability:
Prometheus
Grafana
Loki
Alertmanager
Jaeger/OpenTelemetry

Reliability:
Autoscaling
PDB
Chaos Testing
SLOs
Incident simulation
Backups
DR



# Cloud-OS: Self-Hosted Cloud Desktop Infrastructure

A production-ready, highly available deployment of the Puter cloud desktop environment. This project serves as a comprehensive demonstration of modern DevOps practices, including containerization, Infrastructure as Code (IaC), Continuous Integration/Continuous Deployment (CI/CD), and robust cloud monitoring.

## 🎯 Project Goals & Architecture
The objective of this project is to take an open-source hosting platform and deploy it using a enterprise-grade DevOps lifecycle:
* **Containerization:** Standardizing the application environment using Docker.
* **Infrastructure as Code:** Provisioning secure AWS cloud infrastructure using Terraform.
* **CI/CD Automation:** Automating builds and deployments via GitHub Actions to AWS EC2.
* **Observability:** Implementing central logging and metrics using the LGTM stack (Loki, Grafana, Tail, Prometheus).

---

## 🛠️ Tech Stack (Planned & In-Progress)
* **Application Platform:** Puter (Node.js)
* **Containerization:** Docker, Docker Compose
* **Cloud Provider:** AWS (EC2, VPC, S3, ECR)
* **Infrastructure as Code:** Terraform
* **CI/CD:** GitHub Actions
* **Monitoring:** Grafana, Prometheus, Loki

---

## 🚀 Current Status & Progress Journal

### Day 1: Project Initiation & Repository Setup
* **Date:** May 24, 2026
* **What I did:** Initialized the repository, tracked the upstream Puter source code, and mapped out the production infrastructure architecture blueprint.
* **What's Next:** Crafting a custom production-ready Dockerfile and testing the application environment locally via Docker Compose.

---

## 💻 How to Run This Project

### Prerequisites
* Docker and Docker Compose installed.
* AWS CLI and Terraform configured (For cloud deployment phase).

### Local Development (Coming Soon)
*(Instructions on how to clone and run `docker compose up` will go here in the next step!)*