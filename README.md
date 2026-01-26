# CogHealth EHR Data

Docker infrastructure for the CogHealth EHR system.

> **Full setup instructions:** See the [main README](https://github.com/cogdeasy/demos-coghealth-ehr-data#readme) for complete setup with all three repos.

## Quick Start

```bash
docker-compose up -d
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
```

## Services

| Service | Port | Credentials |
|---------|------|-------------|
| PostgreSQL | 5432 | coghealth / coghealth_dev_2024 |
| Redis | 6379 | - |
| Keycloak | 8180 | admin / admin |
| RabbitMQ | 5672, 15672 | coghealth / coghealth_dev_2024 |
| Elasticsearch | 9200 | - |
| Kibana | 5601 | - |

## Files

| File | Description |
|------|-------------|
| docker-compose.yml | Infrastructure services |
| seed.sql | Database seed data |
| docker/keycloak/ | Keycloak realm config |

## Commands

```bash
docker-compose up -d      # Start
docker-compose down       # Stop
docker-compose logs -f    # View logs
```
