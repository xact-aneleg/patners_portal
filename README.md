# sy195 v2.0 — Bulk Import/Export + Partner Portal

XactERP Solutions (Pty) Ltd  
Spring Boot 3.3.4 + React 18 + PostgreSQL

---

## What's in this project

### sy195 — Bulk Import/Export (original)
Export and import master table data (Debtors, Stock, Creditors, GL) to and from Excel files.

### Partner Portal (new in v2)
A channel partner portal for registering new customer companies with a two-package approval workflow (Xact Lite and Xact Pro).

---

## Quick start

### Prerequisites
| Tool | Version | Check |
|------|---------|-------|
| Java | 17+ | `java -version` |
| Maven | 3.9+ | `mvn -version` |
| Node.js | 18+ | `node -version` |
| PostgreSQL | 13+ | `psql --version` |

### 1 — Create the database
```bash
psql -U postgres -c "CREATE DATABASE xactdev;"
psql -U postgres -d xactdev -f backend/src/main/resources/schema.sql
psql -U postgres -d xactdev -f backend/src/main/resources/seed.sql
```

### 2 — Configure your password
Edit `backend/src/main/resources/application.properties`:
```properties
spring.datasource.password=YOUR_POSTGRES_PASSWORD
```

### 3 — Start the backend
```cmd
cd backend
mvn spring-boot:run
```
Wait for: `Started Sy195Application`

### 4 — Start the frontend (new terminal)
```cmd
cd frontend
npm install
npm run dev
```
Open: http://localhost:5173

---

## Demo accounts (Partner Portal)

| Role | Email | Password |
|------|-------|----------|
| Channel Partner | partner@acme.co.za | password123 |
| XactERP Admin | admin@xacterp.co.za | password123 |
| Imply Approver | approver@imply.co.za | password123 |

Click **Partner Portal** in the topbar mode switcher to access the portal.

---

## API endpoints

### sy195 Bulk Import/Export (no auth required)
| Method | URL | Description |
|--------|-----|-------------|
| POST | /api/export/debtors | Export dl01_mast with filters |
| POST | /api/export/stock | Export st01_mast |
| POST | /api/export/creditors | Export cl01_mast |
| POST | /api/export/gl | Export gl01_mast |
| GET | /api/export/{module}/template | Download blank import template |
| POST | /api/import/debtors | Import dl01_mast |
| POST | /api/import/stock | Import st01_mast |
| POST | /api/import/creditors | Import cl01_mast |
| POST | /api/import/gl | Import gl01_mast |
| GET | /api/conversion/export/{module} | Full table export |
| POST | /api/conversion/import | Conversion import |
| GET | /api/conversion/count/{module} | Row count |
| GET | /api/lookup/{module}?q= | Autocomplete search |
| GET | /api/lookup/range/{module} | First/last code |
| GET | /api/health | Health check |

### Partner Portal (JWT required — except /auth)
| Method | URL | Role | Description |
|--------|-----|------|-------------|
| POST | /api/portal/auth/login | Public | Login, returns JWT |
| POST | /api/portal/auth/register | Public | Partner self-registration |
| GET | /api/portal/registrations | PARTNER | List own registrations |
| POST | /api/portal/registrations | PARTNER | Create new registration |
| PUT | /api/portal/registrations/{id} | PARTNER | Update draft |
| GET | /api/portal/registrations/{id} | All | Full registration detail |
| POST | /api/portal/registrations/{id}/submit | PARTNER | Submit for approval |
| POST | /api/portal/registrations/{id}/approve-imply | IMPLY | Imply approves |
| POST | /api/portal/registrations/{id}/decline-imply | IMPLY | Imply declines |
| POST | /api/portal/registrations/{id}/approve-xact | XACT_ADMIN | XactERP approves |
| POST | /api/portal/registrations/{id}/decline-xact | XACT_ADMIN | XactERP declines |
| POST | /api/portal/registrations/{id}/convert | XACT_ADMIN | Trigger conversion |
| GET | /api/portal/registrations/{id}/conversion-status | All | Job status |
| GET | /api/portal/admin/registrations | XACT_ADMIN | All registrations |
| GET | /api/portal/admin/pending-xact | XACT_ADMIN | Pending XactERP queue |
| GET | /api/portal/admin/pending-imply | IMPLY | Pending Imply queue |

---

## Workflow

### Xact Lite
```
Partner submits → PENDING_XACT → XactERP approves → CONVERTING → LIVE
                                → XactERP declines → DECLINED_XACT
```

### Xact Pro
```
Partner submits → PENDING_IMPLY → Imply approves → PENDING_XACT → XactERP approves → CONVERTING → LIVE
                                → Imply declines → DECLINED_IMPLY
                                                                  → XactERP declines → DECLINED_XACT
```

---

## Project structure

```
sy195/
├── backend/
│   ├── pom.xml
│   └── src/main/java/com/xact/sy195/
│       ├── config/         CorsConfig, SecurityConfig
│       ├── security/       JwtUtil, JwtFilter
│       ├── model/          Entities (existing + 6 portal models)
│       ├── repository/     JPA repos (existing + 6 portal repos)
│       ├── dto/            FilterDTOs, ConversionConfigDTO, PortalDTOs
│       ├── service/        Business logic (existing + PartnerService, RegistrationService)
│       └── controller/     REST endpoints (existing + PortalAuthController, RegistrationController, AdminController)
└── frontend/
    └── src/
        ├── pages/          sy195 module pages (Debtors, Stock, Creditors, GL, Conversion)
        ├── components/     Shared UI components + LookupField
        ├── api/            bulkApi.js
        ├── styles/         global.css
        ├── App.jsx         Root layout with mode switcher (sy195 ↔ Portal)
        └── portal/         Partner Portal
            ├── api/        portalApi.js
            ├── components/ StatusPill
            └── pages/      LoginPage, PartnerDashboard, RegistrationForm,
                            ApprovalQueue, AdminDashboard, RegistrationDetail
```
