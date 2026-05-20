# CogHealth EHR Data — Repository Summary

## Overview

This repository provides the **infrastructure and seed data layer** for the CogHealth EHR (Electronic Health Record) demo application. It defines all Docker-based services, the relational database schema, clinical seed data, and Keycloak identity/access management configuration required to run the full CogHealth EHR system.

It is one of three repositories that compose the complete application:

| Repo | Role | Tech |
|------|------|------|
| **[demos-coghealth-ehr-data](https://github.com/COG-GTM/demos-coghealth-ehr-data)** (this repo) | Infrastructure & data | Docker, PostgreSQL, Redis, Keycloak, RabbitMQ, Elasticsearch |
| [demos-coghealth-ehr-api](https://github.com/COG-GTM/demos-coghealth-ehr-api) | REST API | Java 11, Spring Boot, Maven |
| [demos-coghealth-ehr-web](https://github.com/COG-GTM/demos-coghealth-ehr-web) | Frontend | React 18, TypeScript, Vite, Tailwind CSS |

---

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────────────────────────────┐
│   React     │────▶│  Spring     │────▶│  Infrastructure (this repo)         │
│   :5173     │     │  Boot :8080 │     │  PostgreSQL · Redis · Keycloak      │
└─────────────┘     └─────────────┘     │  RabbitMQ · Elasticsearch · Kibana  │
                                        └─────────────────────────────────────┘
```

The API and Web repos depend on this infrastructure being up and running.

---

## Repository Structure

```
.
├── README.md                          # Setup instructions and quick-start guide
├── docker-compose.yml                 # Multi-container service definitions (6 services)
├── seed.sql                           # Full schema (16 tables) + clinical demo data
├── start-infrastructure.sh            # Automated startup script with health checks
└── docker/
    └── keycloak/
        └── coghealth-realm.json       # Keycloak realm config (roles, users, clients)
```

---

## Infrastructure Services

| Service | Image | Port(s) | Purpose | Credentials |
|---------|-------|---------|---------|-------------|
| **PostgreSQL** | `postgres:14-alpine` | 5432 | Primary relational database | `coghealth` / `coghealth_dev_2024` |
| **Redis** | `redis:7-alpine` | 6379 | Session cache & caching layer | *(none)* |
| **Keycloak** | `quay.io/keycloak/keycloak:23.0` | 8180 | Identity & access management (SSO, RBAC) | `admin` / `admin` |
| **RabbitMQ** | `rabbitmq:3-management-alpine` | 5672, 15672 | Message queue (HL7, async notifications) | `coghealth` / `coghealth_dev_2024` |
| **Elasticsearch** | `elasticsearch:8.11.0` | 9200 | Immutable audit trail storage | *(none)* |
| **Kibana** | `kibana:8.11.0` | 5601 | Audit log visualization UI | *(none)* |

> **HAPI FHIR** (HL7 FHIR R4 server) is defined but commented out in `docker-compose.yml` — it requires Docker Hub authentication.

All services share a `coghealth-network` bridge network. Named volumes provide data persistence (`postgres_data`, `redis_data`, `rabbitmq_data`, `elasticsearch_data`).

---

## Database Schema

The `seed.sql` file defines **16 tables** managed via Flyway migration versioning:

### Clinical Domain

| Table | Description | Key Columns |
|-------|-------------|-------------|
| `patients` | Patient demographics & contact info | `mrn` (unique), `ssn`, name, DOB, gender, address, emergency contact |
| `patient_identifiers` | Additional patient IDs (MRN, insurance, etc.) | `identifier_type`, `identifier_value`, `issuing_authority` |
| `emergency_contacts` | Patient emergency contacts with priority ranking | `relationship`, `priority`, phone numbers |
| `providers` | Clinicians & staff | `npi` (unique), credentials, specialty, department |
| `provider_licenses` | Professional license tracking | `license_type`, `license_number`, state, expiration |
| `encounters` | Clinical visits/interactions | `encounter_number`, type, status, chief complaint, location |
| `diagnoses` | ICD-10 coded diagnoses | `icd10_code`, severity, chronic flag, onset/abatement dates |
| `encounter_diagnoses` | Links encounters to diagnoses | `role`, `rank`, `primary_diagnosis` flag |
| `allergies` | Patient allergy records | `allergy_type`, `allergen`, severity, reaction |
| `clinical_notes` | Provider documentation | `note_type`, content, signing/cosigning workflow, amendments |
| `vitals` | Physiological measurements | BP, HR, temp, O₂ sat, BMI, pain level |
| `medications` | Medication reference catalog | `ndc_code`, `rxnorm_code`, strength, form, route, controlled status |
| `medication_orders` | Prescriptions / orders | `sig`, dose, frequency, refills, pharmacy info, DAW flag |
| `medication_administrations` | MAR (Medication Administration Record) | scheduled vs. administered times, dose given, site |
| `insurance_coverages` | Patient insurance information | payer, plan, member ID, copay, deductible, subscriber info |
| `lab_orders` / `lab_results` | Laboratory test orders and results | test code/name, specimen, reference ranges, flags |
| `audit_events` | Immutable access/change audit trail | user, action, resource, IP, session, timestamp |

### Seed Data Volume

| Entity | Count |
|--------|-------|
| Providers | 8 (across 7 specialties) |
| Patients | 15 |
| Encounters | 18 (15 completed, 1 in-progress, 2 scheduled) |
| Diagnoses | 11 |
| Allergies | 8 |
| Medications | 15 |
| Medication Orders | 7 |
| Vitals | 12 |
| Audit Events | 5 (samples) |

---

## Identity & Access Management (Keycloak)

The `coghealth-realm.json` configures a **coghealth** realm with role-based access control:

### Roles

| Role | Description |
|------|-------------|
| `physician` | Full clinical access |
| `nurse` | Clinical access, limited prescribing |
| `medical_assistant` | Vitals, scheduling, limited chart access |
| `front_desk` | Scheduling, demographics only |
| `billing` | Claims, payments, limited PHI |
| `admin` | Full system access |
| `compliance_officer` | Audit logs and reports, no clinical modification |

### Demo Users

| Username | Name | Role | Password |
|----------|------|------|----------|
| `dr.anderson` | Sarah Anderson | Physician | `demo123` |
| `nurse.johnson` | Mike Johnson | Nurse | `demo123` |
| `ma.smith` | Jane Smith | Medical Assistant | `demo123` |
| `frontdesk.wilson` | Tom Wilson | Front Desk | `demo123` |
| `billing.garcia` | Maria Garcia | Billing | `demo123` |
| `compliance.lee` | Jennifer Lee | Compliance Officer | `demo123` |
| `admin` | System Administrator | Admin | `admin123` |

### OAuth Clients

| Client ID | Type | Purpose |
|-----------|------|---------|
| `coghealth-api` | Confidential | Backend service-to-service auth (secret: `coghealth-api-secret-2024`) |
| `coghealth-web` | Public | Browser-based SPA auth (ports 5173, 3000) |

### Security Features

- Brute-force protection enabled (lockout after 5 failures)
- Password reset allowed
- Email-based login supported
- Self-registration disabled
- Custom token claims: realm roles, NPI attribute

---

## Deployment Options

### Option 1: Neon Cloud (Recommended — No Docker)

Uses a shared cloud PostgreSQL instance with pre-seeded data. Only the API and Web repos need to be started locally.

### Option 2: Local Docker

Run `docker-compose up -d` followed by seeding:
```bash
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
```

### Startup Script

`start-infrastructure.sh` automates the full lifecycle:
1. Verifies Docker is running
2. Stops existing containers
3. Starts all services via `docker-compose up -d`
4. Waits for each service to pass health checks (PostgreSQL, Redis, Keycloak, RabbitMQ, Elasticsearch, HAPI FHIR)
5. Prints service URLs and demo credentials

---

## Service URLs (Local Docker)

| Service | URL |
|---------|-----|
| Web App | http://localhost:5173 |
| API Swagger | http://localhost:8080/api/swagger-ui/index.html |
| Keycloak Admin | http://localhost:8180 |
| RabbitMQ Management | http://localhost:15672 |
| Elasticsearch | http://localhost:9200 |
| Kibana | http://localhost:5601 |

---

## Key Clinical Concepts

| Term | Definition |
|------|------------|
| **MRN** | Medical Record Number — unique patient business identifier (format: `MRN-YYYY-NNNNN`) |
| **NPI** | National Provider Identifier — standard 10-digit clinician ID |
| **ICD-10** | International Classification of Diseases coding for diagnoses |
| **NDC** | National Drug Code — medication identification |
| **RxNorm** | Standardized clinical drug nomenclature |
| **SIG** | Standardized prescribing instructions (e.g., "Take one tablet by mouth once daily") |
| **DAW** | Dispense As Written — brand-specific prescription flag |
| **MAR** | Medication Administration Record |
| **Encounter** | A specific clinical interaction between patient and provider |
| **Flyway** | Database migration versioning tool (schema history tracked in `flyway_schema_history`) |

---

## License

Demo Application — Cognition AI
