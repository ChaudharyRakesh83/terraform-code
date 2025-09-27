# Terraform + Monitoring Stack

## 📌 Overview
This repo contains:
1. **Terraform Infrastructure** (`terraform-infra/`)  
   - Creates VPC, Subnets, EC2, S3, etc.  
   - Modularized with `vpc-module`  

2. **Monitoring Stack** (`monitoring-stack/`)  
   - Docker Compose setup with **Prometheus, Loki, Promtail**  
   - Custom `node-alert-rules.yml` for alerts  

---

## 🚀 Usage

### 1️⃣ Deploy Infrastructure
```bash
cd terraform-infra
terraform init
terraform apply -auto-approve

##############################
ssh EC2 instance
cd prom-grafana-setup/
docker-compose up -d
