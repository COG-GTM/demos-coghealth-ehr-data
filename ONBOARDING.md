# CogHealth EHR - New Team Member Onboarding Guide

Welcome to the CogHealth EHR project! This document provides a comprehensive overview of the entire system across all three repositories. By the end of this guide you should understand the architecture, how the repos relate to each other, how to set up your development environment, and how to navigate the codebase.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [System Architecture](#system-architecture)
3. [Repository Map](#repository-map)
4. [Technology Stack](#technology-stack)
5. [Getting Started (Full Setup)](#getting-started-full-setup)
6. [Repository Deep Dives](#repository-deep-dives)
   - [demos-coghealth-ehr-data](#1-demos-coghealth-ehr-data-infrastructure--data)
   - [demos-coghealth-ehr-api](#2-demos-coghealth-ehr-api-backend)
   - [demos-coghealth-ehr-web](#3-demos-coghealth-ehr-web-frontend)
7. [Database Schema](#database-schema)
8. [API Reference](#api-reference)
9. [Authentication & RBAC](#authentication--rbac)
10. [HIPAA Compliance & Audit Logging](#hipaa-compliance--audit-logging)
11. [Healthcare Standards (FHIR / HL7)](#healthcare-standards-fhir--hl7)
12. [Development Workflows](#development-workflows)
13. [CI/CD Pipelines](#cicd-pipelines)
14. [Key Design Patterns](#key-design-patterns)
15. [Known Intentional HIPAA Gaps (Demo Purposes)](#known-intentional-hipaa-gaps-demo-purposes)
16. [Troubleshooting](#troubleshooting)
17. [Glossary](#glossary)

---

## Project Overview

**CogHealth EHR** is a demo Electronic Health Record (EHR) system built to showcase a realistic healthcare application. It simulates the core workflows of a medical practice: patient management, clinical encounters, medication ordering, lab results, vitals tracking, scheduling, and billing.

The system is split across **three repositories**:

| Repository | Purpose | Language |
|---|---|---|
| `demos-coghealth-ehr-data` | Infrastructure (Docker), database schema, seed data | Shell / SQL |
| `demos-coghealth-ehr-api` | Backend REST API | Java 11 (Spring Boot 2.7) |
| `demos-coghealth-ehr-web` | Frontend web application | TypeScript (React 19, Vite) |

> **Important:** This is a demo/educational application. It contains **intentional HIPAA compliance gaps** for audit demonstration purposes. It should never be used with real patient data.

---

## System Architecture

```
                        ┌──────────────────────────────────┐
                        │         Web Browser (User)        │
                        │     http://localhost:5173          │
                        └──────────────┬───────────────────┘
                                       │  HTTP (REST/JSON)
                                       ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                     demos-coghealth-ehr-web                              │
│                                                                          │
│   React 19 + TypeScript + Vite + Tailwind CSS                           │
│   ┌─────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐  │
│   │  Dashboard   │ │  Patients    │ │  Schedule    │ │  Labs        │  │
│   │  Page        │ │  Search/Chart│ │  Page        │ │  Results     │  │
│   ├─────────────┤ ├──────────────┤ ├──────────────┤ ├──────────────┤  │
│   │  Vitals     │ │  Medications │ │  Reports     │ │  Settings    │  │
│   │  Page       │ │  Page        │ │  Page        │ │  Page        │  │
│   └─────────────┘ └──────────────┘ └──────────────┘ └──────────────┘  │
│                                                                          │
│   State: Zustand  │  Data Fetching: TanStack Query  │  Forms: React    │
│                   │                                   │  Hook Form + Zod │
└──────────────────────────────┬───────────────────────────────────────────┘
                               │  VITE_API_URL (default: http://localhost:8080/api)
                               ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                     demos-coghealth-ehr-api                              │
│                                                                          │
│   Spring Boot 2.7.18 (Java 11) — Port 8080, context-path: /api         │
│                                                                          │
│   ┌──────────────────────────────────────────────────────────────────┐  │
│   │ Controllers                                                       │  │
│   │  /v1/patients    /v1/encounters    /v1/providers    /v1/export    │  │
│   └──────────────────────────────────────────────────────────────────┘  │
│   ┌──────────────────────────────────────────────────────────────────┐  │
│   │ Services                                                          │  │
│   │  PatientService  EncounterService  ProviderService                │  │
│   │  AppointmentService  InsuranceGateway  ProviderNotificationSvc    │  │
│   │  Chronic Care: ChronicMedicationSvc  MedicationAdherenceTracker   │  │
│   └──────────────────────────────────────────────────────────────────┘  │
│   ┌──────────────────────────────────────────────────────────────────┐  │
│   │ Cross-cutting                                                     │  │
│   │  @AuditAccess (AOP)  │  PatientMapper (MapStruct)                │  │
│   │  FhirPatientMapper   │  SecurityConfig (CORS, no auth for dev)   │  │
│   └──────────────────────────────────────────────────────────────────┘  │
│   ┌──────────────────────────────────────────────────────────────────┐  │
│   │ Legacy (Intentional HIPAA issues for demo)                        │  │
│   │  LegacyPatientLookup  InsuranceCache  EncounterExportService     │  │
│   │  ReportGenerator                                                  │  │
│   └──────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────┬───────────────────────────────────────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐   ┌──────────────────┐   ┌──────────────────┐
│  PostgreSQL   │   │     Redis        │   │   Elasticsearch  │
│  :5432        │   │    :6379         │   │    :9200         │
│               │   │                  │   │                  │
│ Patient data  │   │ Session cache    │   │ Audit logs       │
│ Clinical data │   │ API cache        │   │ Search index     │
│ Orders        │   │ Rate limiting    │   │ Analytics        │
│ Audit trail   │   │                  │   │                  │
└───────────────┘   └──────────────────┘   └──────────────────┘
        │
        │   (all managed by Docker Compose)
        │
┌───────────────┐   ┌──────────────────┐   ┌──────────────────┐
│   Keycloak    │   │    RabbitMQ      │   │     Kibana       │
│   :8180       │   │  :5672 / :15672  │   │    :5601         │
│               │   │                  │   │                  │
│ OAuth 2.0     │   │ HL7 messages     │   │ Log viewer       │
│ RBAC          │   │ Async tasks      │   │ Dashboards       │
│ MFA           │   │ Notifications    │   │ Audit review     │
└───────────────┘   └──────────────────┘   └──────────────────┘

         ▲ All infrastructure containers defined in:
         │ demos-coghealth-ehr-data/docker-compose.yml
```

### Request Flow (Simplified)

1. User opens `http://localhost:5173` (React frontend)
2. Frontend makes REST calls to `http://localhost:8080/api/v1/...`
3. API processes request through controller -> service -> repository layers
4. Audit logging captures PHI access events via `@AuditAccess` AOP annotation
5. Data is read/written to PostgreSQL; cache operations go to Redis
6. Response is returned as JSON to the frontend

---

## Repository Map

### demos-coghealth-ehr-data (This Repo)

The "hub" repo. Contains all infrastructure definitions and is the starting point for setup.

```
demos-coghealth-ehr-data/
├── README.md                  # Main README with full setup instructions
├── ONBOARDING.md              # This file - comprehensive onboarding guide
├── docker-compose.yml         # All infrastructure service definitions
├── seed.sql                   # Full database schema + seed data (630 lines)
├── start-infrastructure.sh    # Script to start all Docker services & wait for health
└── docker/
    └── keycloak/
        └── coghealth-realm.json  # Keycloak realm configuration (users, roles, clients)
```

### demos-coghealth-ehr-api

```
demos-coghealth-ehr-api/
├── pom.xml                         # Maven build (Spring Boot 2.7.18, Java 11)
├── docker-compose.yml              # Duplicate of data repo (for standalone use)
├── start.sh                        # Interactive start script (local DB vs Neon cloud)
├── AGENTS.md                       # AI agent instructions & patterns reference
├── INFRASTRUCTURE.md               # Full architecture diagrams, RBAC matrix, env vars
├── .github/workflows/ci.yml        # CI: compile, test, verify
├── docker/keycloak/                # Keycloak realm config (same as data repo)
├── frontend/                       # (empty - frontend is in separate repo)
└── src/main/
    ├── java/com/medchart/ehr/
    │   ├── MedchartEhrApplication.java    # Spring Boot main class
    │   ├── config/
    │   │   └── SecurityConfig.java        # CORS config, auth disabled for dev
    │   ├── controller/
    │   │   ├── PatientController.java     # /v1/patients - CRUD + search
    │   │   ├── EncounterController.java   # /v1/encounters - full lifecycle
    │   │   ├── ProviderController.java    # /v1/providers - CRUD + search
    │   │   └── LegacyExportController.java# /v1/export - CSV/report exports
    │   ├── domain/                        # JPA entities organized by domain
    │   │   ├── patient/                   # Patient, Address, EmergencyContact, Gender, etc.
    │   │   ├── encounter/                 # Encounter, EncounterDiagnosis, enums
    │   │   ├── clinical/                  # ClinicalNote, Allergy, Diagnosis, Vitals
    │   │   ├── medication/                # Medication, MedicationOrder, MedicationAdministration
    │   │   ├── order/                     # LabOrder, LabResult, enums
    │   │   ├── insurance/                 # InsuranceCoverage, CoverageType
    │   │   ├── provider/                  # Provider, License, ProviderType
    │   │   └── chronic/                   # ChronicCondition, DiabetesManagement, MedicationAdherence
    │   ├── dto/                           # Data transfer objects
    │   │   ├── PatientDTO.java
    │   │   ├── AddressDTO.java
    │   │   ├── EmergencyContactDTO.java
    │   │   └── PatientIdentifierDTO.java
    │   ├── repository/                    # Spring Data JPA repositories
    │   │   ├── PatientRepository.java
    │   │   ├── EncounterRepository.java
    │   │   └── ProviderRepository.java
    │   ├── service/                       # Business logic layer
    │   │   ├── PatientService.java        # Patient CRUD with audit logging
    │   │   ├── EncounterService.java      # Encounter lifecycle management
    │   │   ├── ProviderService.java       # Provider management
    │   │   ├── AppointmentService.java    # Scheduling & insurance eligibility
    │   │   ├── InsuranceGateway.java      # External insurance verification (circuit breaker)
    │   │   ├── ProviderNotificationService.java # Async notifications
    │   │   └── chronic/                   # Chronic care stubs (partially implemented)
    │   │       ├── ChronicMedicationService.java
    │   │       ├── MedicationAdherenceTracker.java
    │   │       ├── PharmacyIntegrationService.java
    │   │       └── MedicationNotificationService.java
    │   ├── mapper/                        # Object mappers
    │   │   ├── PatientMapper.java         # MapStruct Patient <-> PatientDTO
    │   │   └── FhirPatientMapper.java     # Internal Patient <-> FHIR R4 resource
    │   ├── audit/                         # HIPAA audit logging system
    │   │   ├── AuditAccess.java           # Custom annotation for audit-logged methods
    │   │   ├── AuditAction.java           # Enum: READ, CREATE, UPDATE, DELETE, SEARCH, EXPORT
    │   │   ├── AuditAspect.java           # AOP aspect that intercepts @AuditAccess methods
    │   │   ├── AuditEvent.java            # Audit event entity
    │   │   ├── AuditEventRepository.java  # JPA repository for audit events
    │   │   ├── AuditService.java          # Async audit event persistence
    │   │   ├── PatientAccessLogger.java   # Convenience logger for patient PHI access
    │   │   └── MedicationAuditLogger.java # Specialized medication audit logging
    │   └── legacy/                        # INTENTIONAL HIPAA GAPS (demo only)
    │       ├── LegacyPatientLookup.java   # Direct JDBC - bypasses audit layer
    │       ├── InsuranceCache.java        # Caches SSN with no TTL
    │       ├── EncounterExportService.java# No audit logging on batch exports
    │       └── ReportGenerator.java       # Writes PHI to temp files without cleanup
    └── resources/
        ├── application.yml                # Default config (local PostgreSQL)
        ├── application-dev.yml            # Neon cloud database config
        └── db/migration/
            ├── V1__initial_schema.sql     # Database schema (Flyway migration)
            └── V2__seed_data.sql          # Seed data (Flyway migration)
```

### demos-coghealth-ehr-web

```
demos-coghealth-ehr-web/
├── package.json                    # Dependencies & scripts
├── vite.config.ts                  # Vite configuration
├── tsconfig.json                   # TypeScript config (base)
├── tsconfig.app.json               # TypeScript config (app)
├── tsconfig.node.json              # TypeScript config (node)
├── tailwind.config.js              # Tailwind CSS configuration
├── postcss.config.js               # PostCSS config
├── eslint.config.js                # ESLint flat config
├── jest.config.cjs                 # Jest test configuration
├── index.html                      # HTML entry point
├── HIPAA_COMPLIANCE.md             # HIPAA compliance checklist with status
├── .github/workflows/ci.yml        # CI: install, lint, build, test
├── public/                         # Static assets
├── tests/                          # Test files (unit + e2e)
└── src/
    ├── main.tsx                    # React entry point (StrictMode)
    ├── App.tsx                     # Root component: routing, navigation, session management
    ├── App.css                     # Global styles (Windows XP-inspired theme)
    ├── index.css                   # Tailwind imports & base styles
    ├── pages/                      # Route-level page components
    │   ├── DashboardPage.tsx       # Overview dashboard with metrics & alerts
    │   ├── PatientSearchPage.tsx   # Patient search with results table
    │   ├── PatientChartPage.tsx    # Full patient chart (demographics, encounters, labs, meds)
    │   ├── SchedulePage.tsx        # Provider scheduling calendar
    │   ├── LabResultsPage.tsx      # Lab results viewer
    │   ├── VitalsPage.tsx          # Vitals flowsheet
    │   ├── MedicationsPage.tsx     # Medication management
    │   ├── ReportsPage.tsx         # Report generation
    │   └── SettingsPage.tsx        # System settings
    ├── components/
    │   ├── patient/                # Patient-specific components
    │   │   ├── PatientBanner.tsx   # Patient header bar with demographics
    │   │   ├── PatientSearch.tsx   # Search form and results
    │   │   └── index.ts            # Barrel exports
    │   └── ui/                     # Reusable UI components
    │       ├── Badge.tsx           # Status badges
    │       ├── Button.tsx          # Styled buttons
    │       ├── Card.tsx            # Card containers
    │       ├── Input.tsx           # Form inputs
    │       ├── LoadingOverlay.tsx  # Loading spinner overlay
    │       ├── Modal.tsx           # AlertDialog, ConfirmDialog
    │       ├── OrderDialog.tsx     # Lab/radiology order dialog
    │       ├── PrescriptionDialog.tsx # Prescription writing dialog
    │       ├── PrintDialog.tsx     # Print preview dialog
    │       └── index.ts            # Barrel exports
    ├── services/                   # API communication layer
    │   ├── api.ts                  # Base HTTP client (fetch wrapper)
    │   ├── patientService.ts       # Patient API calls (/v1/patients/*)
    │   ├── encounterService.ts     # Encounter API calls (/v1/encounters/*)
    │   ├── auditService.ts         # Client-side audit logging (localStorage)
    │   └── index.ts                # Barrel exports
    ├── types/                      # TypeScript type definitions
    │   ├── patient.ts              # Patient, Address, EmergencyContact, Gender, etc.
    │   ├── encounter.ts            # Encounter, EncounterType, EncounterStatus
    │   ├── medication.ts           # Medication, MedicationOrder, DrugSchedule
    │   ├── lab.ts                  # LabResult, LabPanel
    │   ├── vitals.ts               # VitalReading, VitalSign
    │   └── index.ts                # Barrel exports
    └── assets/                     # Static assets (images, icons)
```

---

## Technology Stack

### Backend (demos-coghealth-ehr-api)

| Technology | Version | Purpose |
|---|---|---|
| Java | 11 | Language runtime |
| Spring Boot | 2.7.18 | Application framework |
| Spring Data JPA | (managed by Boot) | ORM / database access |
| Spring Security | (managed by Boot) | Auth framework (disabled for dev) |
| Spring AOP | (managed by Boot) | Aspect-oriented audit logging |
| PostgreSQL Driver | (managed by Boot) | Database connectivity |
| Flyway | (managed by Boot) | Database migration management |
| Redis | (via Spring Data Redis) | Caching & session store |
| Lombok | 1.18.36 | Boilerplate reduction |
| MapStruct | 1.5.5 | Type-safe object mapping |
| SpringDoc OpenAPI | 1.7.0 | Swagger UI / API docs |
| HAPI HL7 | 2.3 | HL7 v2.x message parsing |
| Maven | (wrapper) | Build tool |

### Frontend (demos-coghealth-ehr-web)

| Technology | Version | Purpose |
|---|---|---|
| React | 19 | UI framework |
| TypeScript | ~5.9 | Type-safe JavaScript |
| Vite | 7.x | Build tool & dev server |
| Tailwind CSS | 4.x | Utility-first CSS |
| TanStack Query | 5.x | Server state management & data fetching |
| Zustand | 5.x | Client state management |
| React Router | 7.x | Client-side routing |
| React Hook Form | 7.x | Form management |
| Zod | 4.x | Schema validation |
| Lucide React | 0.562 | Icon library |
| ESLint | 9.x | Linting |
| Jest | 30.x | Testing |
| Puppeteer | 24.x | E2E testing |

### Infrastructure (demos-coghealth-ehr-data)

| Service | Image | Port | Purpose |
|---|---|---|---|
| PostgreSQL | `postgres:14-alpine` | 5432 | Primary database |
| Redis | `redis:7-alpine` | 6379 | Cache & session store |
| Keycloak | `keycloak:23.0` | 8180 | Identity provider (OAuth 2.0, RBAC) |
| RabbitMQ | `rabbitmq:3-management-alpine` | 5672, 15672 | Message queue (HL7, async) |
| Elasticsearch | `elasticsearch:8.11.0` | 9200 | Audit log storage & search |
| Kibana | `kibana:8.11.0` | 5601 | Audit log visualization |
| HAPI FHIR | `hapiproject/hapi:latest` | 8090 | FHIR R4 server (commented out) |

---

## Getting Started (Full Setup)

### Prerequisites

- **Docker Desktop** (or Docker Engine + Compose)
- **Java 17** (for running the API; `brew install openjdk@17` on macOS)
- **Maven** (for building the API; `brew install maven` on macOS)
- **Node.js 18+** (for the frontend; `brew install node` on macOS)

### Step-by-Step Setup

```bash
# 1. Clone all three repos side by side
git clone git@github.com:COG-GTM/demos-coghealth-ehr-data.git data
git clone git@github.com:COG-GTM/demos-coghealth-ehr-api.git api
git clone git@github.com:COG-GTM/demos-coghealth-ehr-web.git web

# 2. Start infrastructure (Docker required)
cd data
docker-compose up -d
# Wait for PostgreSQL to be ready, then seed the database:
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
cd ..

# 3. Start the API
cd api
# Option A: Local PostgreSQL (the Docker one you just started)
mvn spring-boot:run
# Option B: Use the interactive script
./start.sh   # Select 1 for local PostgreSQL, 2 for Neon cloud
cd ..

# 4. Start the frontend
cd web
npm install
npm run dev
cd ..
```

### Verify Everything Works

| What | URL | Expected |
|---|---|---|
| Frontend | http://localhost:5173 | CogHealth EHR dashboard |
| API Swagger | http://localhost:8080/api/swagger-ui/index.html | API documentation |
| Keycloak Admin | http://localhost:8180 | Login with `admin`/`admin` |
| RabbitMQ Management | http://localhost:15672 | Login with `coghealth`/`coghealth_dev_2024` |
| Elasticsearch | http://localhost:9200 | JSON cluster info |
| Kibana | http://localhost:5601 | Kibana dashboard |

### Database Options

**Local (default):** Uses Docker PostgreSQL with seed data. No env vars needed.

**Neon (cloud):** Set environment variables and run with the `dev` profile:
```bash
export NEON_DB_URL=jdbc:postgresql://your-endpoint.neon.tech/neondb?sslmode=require
export NEON_DB_USERNAME=your-username
export NEON_DB_PASSWORD=your-password
cd api && mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

---

## Database Schema

The database schema is defined in `seed.sql` (in this repo) and also as Flyway migrations in the API repo (`src/main/resources/db/migration/V1__initial_schema.sql`).

### Entity-Relationship Overview

```
┌─────────────┐       ┌───────────────────┐       ┌───────────────┐
│  providers   │◄──────│    encounters     │──────►│   patients    │
│              │       │                   │       │               │
│ id           │       │ id                │       │ id            │
│ npi          │       │ encounter_number  │       │ mrn           │
│ first_name   │       │ patient_id (FK)   │       │ ssn           │
│ last_name    │       │ provider_id (FK)  │       │ first_name    │
│ credentials  │       │ attending_prov_id │       │ last_name     │
│ specialty    │       │ encounter_type    │       │ date_of_birth │
│ department   │       │ status            │       │ gender        │
│ active       │       │ encounter_date    │       │ email, phone  │
└──────┬───────┘       │ chief_complaint   │       │ address       │
       │               │ notes             │       │ active        │
       │               └─────────┬─────────┘       └──────┬────────┘
       │                         │                         │
       │                         │                         │
       │    ┌────────────────────┼────────────────┐        │
       │    │                    │                │        │
       │    ▼                    ▼                ▼        │
┌──────┴────────┐  ┌─────────────────┐  ┌──────────────┐  │
│ provider_     │  │ encounter_      │  │  clinical_   │  │
│ licenses      │  │ diagnoses       │  │  notes       │  │
└───────────────┘  └─────────────────┘  └──────────────┘  │
                                                           │
       ┌───────────────────────┬───────────────────────────┤
       │                       │                           │
       ▼                       ▼                           ▼
┌──────────────┐   ┌───────────────────┐   ┌──────────────────────┐
│  allergies   │   │   diagnoses       │   │  insurance_coverages │
│              │   │                   │   │                      │
│ patient_id   │   │ patient_id (FK)   │   │ patient_id (FK)      │
│ allergen     │   │ icd10_code        │   │ payer_name           │
│ severity     │   │ description       │   │ member_id            │
│ reaction     │   │ status            │   │ plan_type            │
└──────────────┘   │ chronic           │   │ coverage_order       │
                   └───────────────────┘   └──────────────────────┘
       │
       ▼
┌──────────────┐   ┌───────────────────┐   ┌──────────────────────┐
│   vitals     │   │  medication_      │   │  lab_orders          │
│              │   │  orders           │   │                      │
│ patient_id   │   │                   │   │ patient_id (FK)      │
│ encounter_id │   │ patient_id (FK)   │   │ ordering_provider_id │
│ temperature  │   │ medication_id(FK) │   │ test_code            │
│ heart_rate   │   │ prescriber_id(FK) │   │ test_name            │
│ blood_press  │   │ dose, frequency   │   │ status               │
│ spo2, bmi    │   │ status            │   │ priority             │
└──────────────┘   └───────┬───────────┘   └──────────┬───────────┘
                           │                           │
                           ▼                           ▼
               ┌───────────────────────┐   ┌──────────────────────┐
               │ medication_           │   │   lab_results        │
               │ administrations       │   │                      │
               │                       │   │ lab_order_id (FK)    │
               │ medication_order_id   │   │ result_code          │
               │ administered_by (FK)  │   │ value, unit          │
               │ dose_given            │   │ reference_range      │
               │ status                │   │ flag (H, L, C)       │
               └───────────────────────┘   └──────────────────────┘

┌──────────────────────────────────────┐   ┌──────────────────────┐
│          medications (reference)      │   │   audit_events       │
│                                      │   │                      │
│ id, ndc_code, rxnorm_code           │   │ user_id              │
│ generic_name, brand_name            │   │ patient_id           │
│ strength, form, route               │   │ action               │
│ schedule (I-V), controlled flag     │   │ resource_type        │
│ warnings, contraindications         │   │ ip_address           │
└──────────────────────────────────────┘   │ timestamp            │
                                           └──────────────────────┘
```

### Key Tables

| Table | Records (Seeded) | Description |
|---|---|---|
| `patients` | 15 | Patient demographics, identifiers, addresses |
| `providers` | 8 | Physicians, NPs with specialties and departments |
| `encounters` | 20+ | Office visits with chief complaints and notes |
| `diagnoses` | Multiple | ICD-10 coded diagnoses (some chronic) |
| `medications` | 10 | Medication reference data (NDC/RxNorm codes) |
| `medication_orders` | Multiple | Prescriptions with dose, frequency, pharmacy |
| `lab_orders` / `lab_results` | Multiple | Lab tests with results and reference ranges |
| `allergies` | Multiple | Patient allergies with severity and reactions |
| `vitals` | Multiple | Vital signs recordings |
| `clinical_notes` | Multiple | SOAP notes, H&P, progress notes |
| `insurance_coverages` | Multiple | Insurance plans with coverage details |
| `audit_events` | Growing | HIPAA audit trail |

### Schema Management

- **Flyway** manages schema migrations automatically on API startup
- Migrations are in `demos-coghealth-ehr-api/src/main/resources/db/migration/`
- `V1__initial_schema.sql` - All table definitions
- `V2__seed_data.sql` - Initial seed data
- The `seed.sql` file in this repo combines both for standalone seeding

---

## API Reference

The API base URL is `http://localhost:8080/api`. All endpoints are prefixed with `/v1/`.

### Patient Endpoints (`/v1/patients`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/v1/patients/{id}` | Get patient by ID |
| `GET` | `/v1/patients/mrn/{mrn}` | Get patient by MRN |
| `GET` | `/v1/patients/search?q={term}&page=0&size=20` | Search patients by name/MRN |
| `POST` | `/v1/patients` | Create new patient |
| `PUT` | `/v1/patients/{id}` | Update patient |

### Encounter Endpoints (`/v1/encounters`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/v1/encounters/{id}` | Get encounter by ID |
| `GET` | `/v1/encounters/number/{num}` | Get encounter by number |
| `GET` | `/v1/encounters/patient/{patientId}` | Get all encounters for a patient |
| `GET` | `/v1/encounters/patient/{patientId}/paged` | Paged encounters for a patient |
| `GET` | `/v1/encounters/provider/{providerId}` | Get encounters for a provider |
| `GET` | `/v1/encounters/provider/{providerId}/schedule?date=YYYY-MM-DD` | Provider daily schedule |
| `GET` | `/v1/encounters/date-range?startDate=...&endDate=...` | Encounters in date range |
| `GET` | `/v1/encounters/status/{status}` | Filter by status |
| `POST` | `/v1/encounters` | Create encounter |
| `PUT` | `/v1/encounters/{id}` | Update encounter |
| `POST` | `/v1/encounters/{id}/check-in` | Check in patient |
| `POST` | `/v1/encounters/{id}/start` | Start encounter |
| `POST` | `/v1/encounters/{id}/complete` | Complete encounter |
| `POST` | `/v1/encounters/{id}/cancel` | Cancel encounter |
| `POST` | `/v1/encounters/{id}/no-show` | Mark as no-show |

### Provider Endpoints (`/v1/providers`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/v1/providers?active=true` | List all (or active) providers |
| `GET` | `/v1/providers/{id}` | Get provider by ID |
| `GET` | `/v1/providers/npi/{npi}` | Get provider by NPI |
| `GET` | `/v1/providers/department/{dept}` | Filter by department |
| `GET` | `/v1/providers/specialty/{spec}` | Filter by specialty |
| `GET` | `/v1/providers/departments` | List all departments |
| `GET` | `/v1/providers/specialties` | List all specialties |
| `GET` | `/v1/providers/search?lastName={name}` | Search by last name |
| `POST` | `/v1/providers` | Create provider |
| `PUT` | `/v1/providers/{id}` | Update provider |
| `DELETE` | `/v1/providers/{id}` | Deactivate provider |

### Export Endpoints (`/v1/export`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/v1/export/encounters?startDate=...&endDate=...` | Export encounters as CSV |
| `GET` | `/v1/export/patient/{id}/encounters` | Export patient encounter history |
| `GET` | `/v1/export/reports/patient-roster` | Generate patient roster report |
| `GET` | `/v1/export/reports/encounter-summary?startDate=...&endDate=...` | Generate encounter summary |
| `GET` | `/v1/export/reports/daily` | Generate daily report (CSV) |

### Interactive API Docs

Swagger UI is available at: http://localhost:8080/api/swagger-ui/index.html

---

## Authentication & RBAC

### Development Mode

**Authentication is disabled for development.** The `SecurityConfig.java` permits all requests (`antMatchers("/**").permitAll()`). CORS is configured to allow requests from `localhost:5173`, `localhost:5178`, and `localhost:3000`.

### Production Architecture (Keycloak)

In a production setup, the system uses Keycloak for:
- **OAuth 2.0 / OpenID Connect** authentication
- **Role-Based Access Control (RBAC)**
- **Multi-Factor Authentication (MFA)**
- **Session management**

The Keycloak realm configuration is at `docker/keycloak/coghealth-realm.json`.

### Demo Users

All users have password: `demo123` (except admin: `admin123`)

| Username | Role | Access Level |
|---|---|---|
| `dr.anderson` | Physician | Full clinical access, prescribing |
| `nurse.johnson` | Nurse | Clinical access, limited prescribing |
| `ma.smith` | Medical Assistant | Vitals, scheduling, limited charts |
| `frontdesk.wilson` | Front Desk | Scheduling, demographics only |
| `billing.garcia` | Billing | Claims, payments, limited PHI |
| `compliance.lee` | Compliance Officer | Audit logs, reports, read-only |
| `admin` | System Admin | Full system access |

### RBAC Access Matrix

| Resource | Physician | Nurse | MA | Front Desk | Billing | Compliance | Admin |
|---|---|---|---|---|---|---|---|
| Patient Demographics | RW | RW | R | RW | R | R | RW |
| Clinical Notes | RW | RW | - | - | - | R | RW |
| Medications | RW | R | R | - | R | R | RW |
| Prescribe | Yes | No | No | No | No | No | No |
| Controlled Rx | Yes* | No | No | No | No | No | No |
| Lab Orders | RW | RW | R | - | R | R | RW |
| Scheduling | RW | RW | RW | RW | R | R | RW |
| Billing/Claims | R | - | - | - | RW | R | RW |
| Audit Logs | - | - | - | - | - | R | RW |
| System Config | - | - | - | - | - | - | RW |

*R = Read, W = Write, RW = Read/Write, - = No Access, * = Requires DEA*

---

## HIPAA Compliance & Audit Logging

### Backend Audit System

The API uses an **AOP-based audit logging system**:

1. **`@AuditAccess` annotation** - Placed on service methods that access PHI
   ```java
   @AuditAccess(action = AuditAction.READ, resourceType = "Patient", description = "View patient record")
   public PatientDTO getPatientById(Long id) { ... }
   ```

2. **`AuditAspect`** - Spring AOP `@Around` advice that intercepts annotated methods and:
   - Captures user ID, IP address, user agent
   - Records the action type, resource, and patient ID
   - Logs success/failure and any error messages
   - Persists events asynchronously via `AuditService`

3. **`AuditEvent` entity** - Stored in `audit_events` table with fields for user, patient, action, IP, timestamp

4. **Specialized loggers**:
   - `PatientAccessLogger` - Convenience methods for patient PHI access events
   - `MedicationAuditLogger` - Specialized logging for medication operations

### Frontend Audit System

The web app has a **client-side audit service** (`auditService.ts`) that:
- Logs events to `localStorage` (demo implementation)
- Tracks: login/logout, session timeouts, patient access, searches, PHI views, prints, orders, prescriptions
- Maintains session IDs and timestamps
- Keeps up to 1,000 log entries

### Session Security

- 15-minute inactivity timeout
- 2-minute warning before session expiry
- Activity resets the timer (clicks, keypresses)
- Logout confirmation dialog
- Session expired dialog with automatic logout

---

## Healthcare Standards (FHIR / HL7)

### FHIR R4 Support

The `FhirPatientMapper` class provides bidirectional mapping between internal `Patient` entities and FHIR R4 Patient resources:

- **`toFhirResource(Patient)`** - Converts to FHIR R4 JSON (Map structure)
  - Maps identifiers (MRN system: `http://hospital.example.org/mrn`, SSN system: `http://hl7.org/fhir/sid/us-ssn`)
  - Maps name, gender, birth date, telecom, address, marital status
  - Handles deceased status and active flag

- **`fromFhirResource(Map)`** - Converts FHIR R4 JSON to internal Patient

### HL7 v2.x Support

- HAPI HL7 library (v2.3) is included for HL7 v2.4 message parsing
- RabbitMQ is configured for async HL7 message processing
- Integration flow: External System -> RabbitMQ -> Message Processor -> Validate -> Transform -> Store

### HAPI FHIR Server

A HAPI FHIR R4 server is defined in `docker-compose.yml` but currently **commented out** (requires Docker Hub authentication). When enabled, it runs on port 8090 and provides a full FHIR R4 REST API.

---

## Development Workflows

### Running Just the Frontend (Mock Data)

The frontend can run independently with hardcoded demo data:

```bash
cd web
npm install
npm run dev
```

Patient search uses a local array of mock patients defined in `App.tsx`. Some pages will show static demo data while API calls will fail gracefully.

### Running Full Stack

```bash
# Terminal 1: Infrastructure
cd data && docker-compose up -d && docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql

# Terminal 2: API
cd api && mvn spring-boot:run

# Terminal 3: Frontend
cd web && npm install && npm run dev
```

### API Development

```bash
cd api

# Compile only
mvn compile

# Run tests
mvn test

# Run with hot reload (Spring Boot DevTools)
mvn spring-boot:run

# Build JAR
mvn package -DskipTests

# Run with Neon cloud DB
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

### Frontend Development

```bash
cd web

# Development server (hot reload on http://localhost:5173)
npm run dev

# Lint
npm run lint

# Build for production
npm run build

# Preview production build
npm run preview

# Run unit tests
npm test

# Run E2E tests
npm run test:e2e
```

### Infrastructure Management

```bash
cd data

# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Stop and remove all data volumes
docker-compose down -v

# View logs
docker-compose logs -f [service_name]

# Reseed database
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql

# Use the interactive startup script
./start-infrastructure.sh
```

---

## CI/CD Pipelines

### API CI (`.github/workflows/ci.yml`)

Triggers on: push/PR to `main`

| Step | Command |
|---|---|
| Setup Java 11 (Temurin) | `actions/setup-java@v4` with Maven cache |
| Compile | `mvn compile -B` |
| Test | `mvn test -B` |
| Verify | `mvn verify -B -DskipTests` |

### Web CI (`.github/workflows/ci.yml`)

Triggers on: push/PR to `main`

| Step | Command |
|---|---|
| Setup Node.js 20 | `actions/setup-node@v4` with npm cache |
| Install | `npm ci` |
| Lint | `npm run lint` |
| Build | `npm run build` |
| Test | `npm test -- --testPathIgnorePatterns=e2e --passWithNoTests` |

---

## Key Design Patterns

### 1. Audit Logging (AOP)

Methods that access PHI are annotated with `@AuditAccess`. The `AuditAspect` intercepts these calls and records audit events asynchronously.

```java
@AuditAccess(action = AuditAction.READ, resourceType = "Patient", description = "View patient")
public PatientDTO getPatient(Long id) { ... }
```

### 2. Insurance Eligibility Check (Cache-Aside)

`AppointmentService` uses a cache-aside pattern:
1. Check Redis cache first
2. On cache miss, call external `InsuranceGateway`
3. Cache the result with a TTL

### 3. Circuit Breaker (External APIs)

`InsuranceGateway` implements a circuit breaker for resilience against external API failures with timeout handling and structured responses.

### 4. Async Notifications

`ProviderNotificationService` uses `@Async` for non-blocking provider notifications supporting multiple channels with graceful failure handling.

### 5. FHIR Resource Mapping

`FhirPatientMapper` converts between internal domain objects and FHIR R4 resources, handling identifier systems, code mappings, and bidirectional conversion.

### 6. DTO Mapping (MapStruct)

`PatientMapper` uses MapStruct for compile-time type-safe mapping between `Patient` entities and `PatientDTO` objects, with null-value handling and selective field ignoring.

### 7. Frontend API Layer

Services use a shared `api.ts` HTTP client that:
- Configures base URL from `VITE_API_URL` environment variable
- Adds `Content-Type: application/json` headers
- Provides typed `get`, `post`, `put`, `delete` methods
- Handles query parameter serialization

---

## Known Intentional HIPAA Gaps (Demo Purposes)

These are **planted intentionally** for HIPAA audit demonstration. Do not "fix" them unless working on the HIPAA audit demo:

| File | Issue | Location |
|---|---|---|
| `PatientService.java` | Logs full SSN in error messages | Line ~85 |
| `EncounterExportService.java` | No audit logging on batch exports | Entire class |
| `LegacyPatientLookup.java` | Direct JDBC bypasses audit layer | Entire class |
| `InsuranceCache.java` | Caches SSN with no TTL/expiration | Entire class |
| `ReportGenerator.java` | Writes PHI to temp files without cleanup | Entire class |
| Multiple endpoints (15+) | Missing access logging | Various controllers |

---

## Troubleshooting

### Docker Services Won't Start

```bash
# Check Docker is running
docker info

# Check port conflicts
lsof -i :5432   # PostgreSQL
lsof -i :6379   # Redis
lsof -i :8180   # Keycloak

# View service logs
docker-compose logs -f postgres
docker-compose logs -f keycloak

# Nuclear option: reset everything
docker-compose down -v
docker system prune -f
./start-infrastructure.sh
```

### Elasticsearch Memory Issues

Elasticsearch needs at least 512MB. If Docker is constrained:
1. Docker Desktop -> Settings -> Resources
2. Increase Memory to at least 4GB

### API Won't Connect to Database

- Verify PostgreSQL is running: `docker exec coghealth-postgres pg_isready -U coghealth`
- Check connection settings in `application.yml`
- Default: `localhost:5432`, user `coghealth`, password `coghealth_dev_2024`, database `coghealth`

### Frontend Can't Reach API

- Verify the API is running on port 8080
- Check CORS configuration in `SecurityConfig.java` allows your frontend origin
- Allowed origins: `localhost:5173`, `localhost:5178`, `localhost:3000`
- Set `VITE_API_URL` if using a different API port

### Flyway Migration Conflicts

If you see Flyway migration errors after reseeding:
```bash
# Drop and recreate
docker exec coghealth-postgres psql -U coghealth -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
docker exec -i coghealth-postgres psql -U coghealth coghealth < seed.sql
```

---

## Glossary

| Term | Definition |
|---|---|
| **EHR** | Electronic Health Record - digital version of a patient's paper chart |
| **PHI** | Protected Health Information - any individually identifiable health info |
| **HIPAA** | Health Insurance Portability and Accountability Act - US healthcare privacy law |
| **MRN** | Medical Record Number - unique patient identifier within the system |
| **NPI** | National Provider Identifier - 10-digit physician/organization identifier |
| **ICD-10** | International Classification of Diseases, 10th edition - diagnosis coding |
| **NDC** | National Drug Code - unique drug product identifier |
| **RxNorm** | Standardized drug nomenclature from the NLM |
| **FHIR** | Fast Healthcare Interoperability Resources - HL7 standard for health data exchange |
| **HL7** | Health Level Seven - standards for electronic health information exchange |
| **RBAC** | Role-Based Access Control |
| **SOAP** | Subjective, Objective, Assessment, Plan - clinical note format |
| **H&P** | History and Physical - comprehensive patient evaluation note |
| **DEA** | Drug Enforcement Administration - required for prescribing controlled substances |
| **NCPDP** | National Council for Prescription Drug Programs - pharmacy data exchange standard |
| **PDC** | Proportion of Days Covered - medication adherence metric |
| **Flyway** | Database migration tool that manages schema versioning |
| **MapStruct** | Compile-time Java bean mapping framework |
| **TanStack Query** | React library for server state management (formerly React Query) |
| **Zustand** | Lightweight React state management library |

---

*Last updated: March 2026*
*CogHealth EHR - Demo Application by Cognition AI*
