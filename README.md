# CogHealth EHR Infrastructure

Docker infrastructure for the CogHealth Electronic Health Record system.

## Repository Structure

This repo is part of the CogHealth EHR system:

| Repo | Description |
|------|-------------|
| **api** | Java Spring Boot backend API |
| **web** | React frontend application |
| **data** (this repo) | Docker infrastructure (PostgreSQL, Redis, Keycloak, etc.) |

## Services

| Service | Purpose | Port |
|---------|---------|------|
| PostgreSQL | Primary database | 5432 |
| Redis | Cache & session store | 6379 |
| Keycloak | Identity provider (SSO, RBAC, MFA) | 8180 |
| RabbitMQ | Message queue (HL7, async notifications) | 5672, 15672 |
| Elasticsearch | Immutable audit logs (HIPAA compliance) | 9200 |
| Kibana | Audit log UI | 5601 |

## Getting Started

### Prerequisites

- Docker Desktop

### Start Infrastructure

```bash
docker-compose up -d
```

### Load Seed Data (first time only)

```bash
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
```

### Stop Infrastructure

```bash
docker-compose down
```

### View Logs

```bash
docker-compose logs -f [service]
```

## Service URLs

| Service | URL | Credentials |
|---------|-----|-------------|
| Keycloak | http://localhost:8180 | admin / admin |
| RabbitMQ | http://localhost:15672 | coghealth / coghealth_dev_2024 |
| Elasticsearch | http://localhost:9200 | - |
| Kibana | http://localhost:5601 | - |

## Demo Users

All demo users have password: `demo123`

| Username | Role |
|----------|------|
| dr.anderson | Physician |
| nurse.johnson | Nurse |
| ma.smith | Medical Assistant |
| frontdesk.wilson | Front Desk |
| billing.garcia | Billing |
| compliance.lee | Compliance Officer |
| admin (password: admin123) | System Admin |

## Data Volumes

Data is stored in Docker volumes (not in this repo):

- `postgres_data` - Patient records, encounters, etc.
- `redis_data` - Cache data
- `rabbitmq_data` - Message queue data
- `elasticsearch_data` - Audit logs

### Exporting Data

To transfer data to another machine:

```bash
docker run --rm -v coghealth_postgres_data:/data -v $(pwd):/backup alpine tar czf /backup/postgres_data.tar.gz -C /data .
```

### Importing Data

```bash
docker volume create coghealth_postgres_data
docker run --rm -v coghealth_postgres_data:/data -v $(pwd):/backup alpine tar xzf /backup/postgres_data.tar.gz -C /data
```
