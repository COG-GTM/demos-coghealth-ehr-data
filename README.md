# CogHealth EHR

Electronic Health Record System - Demo Application

## Quick Start (Neon Cloud DB — no Docker needed)

```bash
# 1. Clone all repos
git clone git@github.com:COG-GTM/demos-coghealth-ehr-data.git data
git clone git@github.com:COG-GTM/demos-coghealth-ehr-api.git api
git clone git@github.com:COG-GTM/demos-coghealth-ehr-web.git web

# 2. Start API (Java 11 required)
cd api
export JAVA_HOME=/opt/homebrew/opt/openjdk@11
export PATH="$JAVA_HOME/bin:$PATH"
export NEON_DB_URL="jdbc:postgresql://<neon-host>/neondb?sslmode=require"
export NEON_DB_USERNAME="<username>"
export NEON_DB_PASSWORD="<password>"
mvn spring-boot:run -Dspring-boot.run.profiles=dev
cd ..

# 3. Start Web (Node.js 20.19+ or 22.12+ required)
cd web
npm install
npm run dev
```

Open http://localhost:5173

Get Neon credentials from your team lead or `.env` file.

### Quick Start (Local Docker)

```bash
# 1. Start infrastructure (Docker required)
cd data
./start-infrastructure.sh   # generates .env with random credentials on first run
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
cd ..

# 2. Start API (reads credentials from data/.env)
cd api
set -a; . ../data/.env; set +a
DB_URL=jdbc:postgresql://localhost:5432/coghealth DB_USERNAME=coghealth DB_PASSWORD="$POSTGRES_PASSWORD" \
  SPRING_REDIS_PASSWORD="$REDIS_PASSWORD" \
  SPRING_RABBITMQ_USERNAME="$RABBITMQ_USER" SPRING_RABBITMQ_PASSWORD="$RABBITMQ_PASSWORD" \
  mvn spring-boot:run
cd ..

# 3. Start Web
cd web
npm install
npm run dev
```

## Repositories

| Repo | Description | Port |
|------|-------------|------|
| [data](https://github.com/COG-GTM/demos-coghealth-ehr-data) (this repo) | Docker infrastructure (PostgreSQL, Redis, Keycloak) | 5432, 6379, 8180 |
| [api](https://github.com/COG-GTM/demos-coghealth-ehr-api) | Spring Boot REST API | 8080 |
| [web](https://github.com/COG-GTM/demos-coghealth-ehr-web) | React frontend | 5173 |

## Prerequisites

**For Neon (cloud DB):**
- Java 11 (`brew install openjdk@11`)
- Node.js 20.19+ or 22.12+ (`nvm install 22`)
- Maven (`brew install maven`)

**For local Docker:**
- All of the above, plus Docker Desktop

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   React     │────▶│  Spring     │────▶│ PostgreSQL  │
│   :5173     │     │  Boot :8080 │     │ (Neon/local)│
└─────────────┘     └─────────────┘     └─────────────┘
```

## Local Credentials

The Docker stack has no credentials in the repo. They are read from `data/.env`, which is
git-ignored. `./start-infrastructure.sh` creates it with random values on first run, or you can
copy `.env.example` to `.env` and fill it in yourself. `docker compose up` refuses to start if a
required value is missing.

Every published port is bound to `127.0.0.1`, so the services can only be reached from your own
machine. To reach them from somewhere else, use an SSH tunnel; don't change the bind address.
Elasticsearch and Kibana run without authentication and depend on the loopback binding.

## Demo Users

All users have the password set in `KC_DEMO_USER_PASSWORD` (`admin` uses `KC_REALM_ADMIN_PASSWORD`).

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
| Keycloak | http://localhost:8180 (`KEYCLOAK_ADMIN` / `KEYCLOAK_ADMIN_PASSWORD`) |
| RabbitMQ | http://localhost:15672 (`RABBITMQ_USER` / `RABBITMQ_PASSWORD`) |

## Infrastructure Services

All ports are bound to `127.0.0.1`. Credential names refer to variables in `.env`.

| Service | Port | Credentials |
|---------|------|-------------|
| PostgreSQL | 5432 | coghealth / `POSTGRES_PASSWORD` |
| Redis | 6379 | `REDIS_PASSWORD` |
| Keycloak | 8180 | `KEYCLOAK_ADMIN` / `KEYCLOAK_ADMIN_PASSWORD` |
| RabbitMQ | 5672, 15672 | `RABBITMQ_USER` / `RABBITMQ_PASSWORD` |
| Elasticsearch | 9200 | none (loopback only) |
| Kibana | 5601 | none (loopback only) |

## Files in This Repo

| File | Description |
|------|-------------|
| docker-compose.yml | Infrastructure services |
| .env.example | Template for the untracked `.env` holding local credentials |
| start-infrastructure.sh | Generates `.env` if missing, starts the stack and waits for health |
| seed.sql | Database seed data |
| docker/keycloak/ | Keycloak realm config |

## Database Options

**Neon (cloud — recommended):** No Docker needed. Uses a shared cloud PostgreSQL instance with pre-seeded data. See Quick Start above.

**Local (Docker):** Uses Docker PostgreSQL with seed data. Requires Docker Desktop. See Local Docker section above.

## Commands

```bash
docker compose up -d      # Start infrastructure (needs .env)
docker compose down       # Stop infrastructure
docker compose logs -f    # View logs
```

## License

Demo Application - Cognition AI
