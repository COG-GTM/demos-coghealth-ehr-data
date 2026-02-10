# CogHealth EHR

Electronic Health Record System - Demo Application

## Quick Start

```bash
# 1. Clone all repos
git clone git@github.com:cogdeasy/demos-coghealth-ehr-data.git data
git clone git@github.com:cogdeasy/demos-coghealth-ehr-api.git api
git clone git@github.com:cogdeasy/demos-coghealth-ehr-web.git web

# 2. Start infrastructure (Docker required)
cd data
docker-compose up -d
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
cd ..

# 3. Start API (Java 21 required)
cd api
./start.sh   # Select 1 for local PostgreSQL
cd ..

# 4. Start Web (Node 18+ required)
cd web
npm install
npm run dev
```

Open http://localhost:5173

## Repositories

| Repo | Description | Port |
|------|-------------|------|
| [data](https://github.com/cogdeasy/demos-coghealth-ehr-data) (this repo) | Docker infrastructure (PostgreSQL, Redis, Keycloak) | 5432, 6379, 8180 |
| [api](https://github.com/cogdeasy/demos-coghealth-ehr-api) | Spring Boot REST API | 8080 |
| [web](https://github.com/cogdeasy/demos-coghealth-ehr-web) | React frontend | 5173 |

## Prerequisites

- Docker Desktop
- Java 21 (`brew install openjdk@21`)
- Node.js 18+ (`brew install node`)
- Maven (`brew install maven`)

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   React     │────▶│  Spring     │────▶│ PostgreSQL  │
│   :5173     │     │  Boot :8080 │     │   :5432     │
└─────────────┘     └─────────────┘     └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │   Redis     │
                    │   :6379     │
                    └─────────────┘
```

## Demo Users

All users have password: `demo123`

| Username | Role |
|----------|------|
| dr.anderson | Physician |
| nurse.johnson | Nurse |
| ma.smith | Medical Assistant |
| frontdesk.wilson | Front Desk |
| billing.garcia | Billing |

## URLs

| Service | URL |
|---------|-----|
| Web App | http://localhost:5173 |
| API Swagger | http://localhost:8080/api/swagger-ui/index.html |
| Keycloak | http://localhost:8180 (admin/admin) |
| RabbitMQ | http://localhost:15672 (coghealth/coghealth_dev_2024) |

## Infrastructure Services

| Service | Port | Credentials |
|---------|------|-------------|
| PostgreSQL | 5432 | coghealth / coghealth_dev_2024 |
| Redis | 6379 | - |
| Keycloak | 8180 | admin / admin |
| RabbitMQ | 5672, 15672 | coghealth / coghealth_dev_2024 |
| Elasticsearch | 9200 | - |
| Kibana | 5601 | - |

## Files in This Repo

| File | Description |
|------|-------------|
| docker-compose.yml | Infrastructure services |
| seed.sql | Database seed data |
| docker/keycloak/ | Keycloak realm config |

## Database Options

**Local (default):** Uses Docker PostgreSQL with seed data.

**Neon (cloud):** Set environment variables and run with dev profile:
```bash
export NEON_DB_URL=jdbc:postgresql://your-endpoint.neon.tech/neondb?sslmode=require
export NEON_DB_USERNAME=your-username
export NEON_DB_PASSWORD=your-password
cd api && ./start.sh  # Select 2 for Neon
```

## Commands

```bash
docker-compose up -d      # Start infrastructure
docker-compose down       # Stop infrastructure
docker-compose logs -f    # View logs
```

## License

Demo Application - Cognition AI
