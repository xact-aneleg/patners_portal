# CLAUDE.md — XactERP sy195 + Partner Portal
> Handover document for Claude Code / new Claude sessions.
> Read this file first before making any changes.

---

## Project overview

Full-stack ERP migration tool + channel partner portal.
- **sy195** — Bulk import/export of master table data (Debtors, Stock, Creditors, GL) to/from Excel
- **Partner Portal** — Channel partners register new companies, workflow approval, automatic database provisioning

**Stack:** Spring Boot 3.3.4 · Java 17 · React 18 · Vite 5 · PostgreSQL 18 · JWT Security

---

## Project location

```
C:\Users\user\Documents\Anele\Spring Boot Projects\XactERP_Complete\sy195\
  backend\    ← Spring Boot
  frontend\   ← React 18 + Vite
```

---

## Start commands

```cmd
rem Terminal 1 — Backend
cd "C:\Users\user\Documents\Anele\Spring Boot Projects\XactERP_Complete\sy195\backend"
mvn spring-boot:run

rem Terminal 2 — Frontend
cd "C:\Users\user\Documents\Anele\Spring Boot Projects\XactERP_Complete\sy195\frontend"
npm run dev
```

App runs at `http://localhost:5173`
API runs at `http://localhost:8080`

---

## Database

- **Engine:** PostgreSQL 18
- **psql path:** `C:\Program Files\PostgreSQL 18\bin\psql.exe`
- **Local dev DB:** `xactdev` (user: `postgres`, password: `anelegasa`)
- **Production server:** `172.30.0.20`, DB: `xactdev_db`, user: `aneleg`

### Schema files (in `backend/src/main/resources/`)
| File | Purpose |
|------|---------|
| `xactdev_schema_clean.sql` | Full real xactdev_db schema — 510 tables. Used for both local setup AND new company provisioning |
| `schema.sql` | Only the 6 Partner Portal tables (`pp_*`) + 3 seed users |
| `seed.sql` | Sample data for debtors, stock, creditors, GL |

### One-time setup (run once)
```cmd
psql -U postgres -c "CREATE DATABASE xactdev;"
psql -U postgres -d xactdev -f "...backend\src\main\resources\xactdev_schema_clean.sql"
psql -U postgres -d xactdev -f "...backend\src\main\resources\schema.sql"
```
Then call: `http://localhost:8080/api/portal/auth/reset-demo-passwords`

---

## Demo accounts (Partner Portal)

| Role | Email | Password |
|------|-------|----------|
| Channel Partner | `partner@acme.co.za` | `password123` |
| XactERP Admin | `admin@xacterp.co.za` | `password123` |
| Imply Approver | `approver@imply.co.za` | `password123` |

If login fails, call: `GET http://localhost:8080/api/portal/auth/reset-demo-passwords`

---

## Architecture

### Backend — key files

```
backend/src/main/java/com/xact/sy195/
  config/
    SecurityConfig.java       ← CORS is configured HERE (not in a separate CorsConfig)
                                Uses .cors(cors -> cors.configurationSource(...))
                                CRITICAL: Do NOT add a separate WebMvcConfigurer CorsConfig
                                It will be ignored by Spring Security and break CORS
  security/
    JwtUtil.java              ← Creates/validates JWT tokens (24hr expiry)
    JwtFilter.java            ← Reads Authorization header on every request
  model/                      ← JPA entities
    Dl01Mast.java             ← dl01_mast (Debtors)
    St01Mast.java             ← st01_mast (Stock)
    Cl01Mast.java             ← cl01_mast (Creditors)
    Gl01Mast.java             ← gl01_mast (GL)
    Gl02LocMast.java          ← gl02_loc_mast (composite PK with @IdClass)
    Partner.java              ← pp_partners
    Registration.java         ← pp_registrations
    RegLocation.java          ← pp_reg_locations
    RegUser.java              ← pp_reg_users
    WorkflowEvent.java        ← pp_workflow_events
    ConversionJob.java        ← pp_conversion_jobs
  service/
    BulkExportService.java    ← Builds JPA Specs from filter DTOs → ExcelService
    BulkImportService.java    ← Reads XLSX row by row, validates, saves
    ExcelService.java         ← Apache POI — creates .xlsx with 3-row header
    ConversionService.java    ← Full table export/truncate+reload for sy999
    PartnerService.java       ← Login (BCrypt), registration, JWT creation
    RegistrationService.java  ← All workflow logic (submit, approve, decline, convert)
    CompanyProvisioningService.java ← Runs xactdev_schema_clean.sql via psql.exe
                                      then seeds sy00_co_mast, gl02_loc_mast,
                                      sy04_access_grps, sy02_user, sy02l_user_loc
  controller/
    BulkController.java       ← /api/export/*, /api/import/*, /api/health
    ConversionController.java ← /api/conversion/*
    LookupController.java     ← /api/lookup/* (autocomplete + range)
    PortalAuthController.java ← /api/portal/auth/* (login, register, reset-demo-passwords)
    RegistrationController.java ← /api/portal/registrations/*
    AdminController.java      ← /api/portal/admin/*
```

### Frontend — key files

```
frontend/src/
  App.jsx                     ← Root — sy195 sidebar + mode switcher (sy195 ↔ Portal)
  App.module.css              ← Topbar, sidebar, collapsible nav, mobile overlay
  styles/global.css           ← CSS variables, form elements, mobile input sizes
  api/
    bulkApi.js                ← All sy195 HTTP calls
                                IMPORTANT: Uses window.location.hostname:8080 directly
                                (NOT through Vite proxy) so other devices on network work
  pages/
    DebtorsPage.jsx           ← dl01_mast filters + export/import tabs
    StockPage.jsx             ← st01_mast filters + export/import tabs
    OtherPages.jsx            ← CreditorsPage + GLPage
    ConversionPage.jsx        ← sy999 — stat cards with live counts, empty+import
    MobilePage.module.css     ← Mobile-first CSS for all sy195 pages
  components/
    LookupField.jsx           ← Autocomplete input (debounced 200ms)
  assets/
    xact.svg                  ← XactERP logo (used in topbar + portal login)
  portal/
    PortalApp.jsx             ← Portal root — auth check, sidebar per role,
                                persistent avatar (localStorage key: pp_avatar)
    PortalApp.module.css      ← Portal sidebar, topbar, Jira-style collapse button
    api/
      portalApi.js            ← All portal HTTP calls with JWT injection
                                IMPORTANT: Uses window.location.hostname:8080 directly
    pages/
      LoginPage.jsx           ← Split layout: dark green left, white right
      LoginPage.module.css    ← Login page styles
      Portal.module.css       ← MAIN portal design system (421 lines)
                                Covers: step wizard, form cards, timeline,
                                queue cards, admin dashboard, approval queue
      RegistrationForm.jsx    ← 5-step wizard (Package/Company/Periods/Locations/Users)
      RegistrationDetail.jsx  ← Read-only detail with KV rows, cards, timeline
      ApprovalQueue.jsx       ← Queue for XACT_ADMIN and IMPLY roles
      AdminDashboard.jsx      ← All registrations with filter tabs
      PartnerDashboard.jsx    ← Partner view — stat cards + registration list
      Dashboard.module.css    ← Partner dashboard styles
    components/
      StatusPill.jsx          ← Colour-coded status badge
```

---

## CORS — critical knowledge

**CORS must be in SecurityConfig.java, NOT a separate file.**

Spring Security intercepts before MVC layer. A separate `WebMvcConfigurer` is ignored.
The working pattern:

```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    return http
        .cors(cors -> cors.configurationSource(corsConfigurationSource()))
        .csrf(c -> c.disable())
        ...
        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
        ...
}

@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowedOriginPatterns(List.of("*"));
    config.setAllowedMethods(List.of("GET","POST","PUT","DELETE","OPTIONS","PATCH"));
    config.setAllowedHeaders(List.of("*"));
    config.setAllowCredentials(false);
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", config);
    return source;
}
```

---

## Multi-device / network access

The app works from phones and colleagues' laptops on the same WiFi.

**How it works:**
- Frontend exposed on `0.0.0.0:5173` via `vite.config.js` (`host: '0.0.0.0'`)
- API calls use `window.location.hostname:8080` dynamically in both `bulkApi.js` and `portalApi.js`
- When phone opens `192.168.7.223:5173`, API calls go to `192.168.7.223:8080` automatically
- Firewall rules needed (run as Admin):
  ```cmd
  netsh advfirewall firewall add rule name="Vite Dev Server" dir=in action=allow protocol=TCP localport=5173
  netsh advfirewall firewall add rule name="Spring Boot Backend" dir=in action=allow protocol=TCP localport=8080
  ```

---

## Partner Portal workflow

### Xact Lite (1-step)
```
DRAFT → PENDING_XACT → CONVERTING → LIVE
                     → DECLINED_XACT
```

### Xact Pro (2-step)
```
DRAFT → PENDING_IMPLY → PENDING_XACT → CONVERTING → LIVE
                      → DECLINED_IMPLY
                                     → DECLINED_XACT
```

### Company provisioning (on approval)
`CompanyProvisioningService.java`:
1. Extracts `xactdev_schema_clean.sql` to temp file
2. Runs `psql.exe -f tempfile.sql` to create the new company database
3. Seeds `sy00_co_mast`, `gl02_loc_mast`, `sy04_access_grps`, `sy02_user`, `sy02l_user_loc` via JDBC

Config in `application.properties`:
```properties
provisioning.psql.path=C:\\Program Files\\PostgreSQL 18\\bin\\psql.exe
provisioning.db.host=localhost
provisioning.db.port=5432
```

---

## application.properties (not in git)

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/xactdev
spring.datasource.username=postgres
spring.datasource.password=anelegasa
portal.jwt.secret=xactErpPartnerPortalSuperSecretKey2024ChangeInProduction
portal.jwt.expiration-ms=86400000
provisioning.psql.path=C:\\Program Files\\PostgreSQL 18\\bin\\psql.exe
provisioning.db.host=localhost
provisioning.db.port=5432
```

---

## UI theme

| Token | Value |
|-------|-------|
| Primary green | `#3aaa35` |
| Dark green | `#2d8828` |
| Light green | `#e8f7e7` |
| Sidebar | `#364553` |
| Accent yellow | `#fbba00` |
| Text | `#1a2733` |
| Muted text | `#6b7c8d` |
| Border | `#d1d9e0` |
| Background | `#f4f6f8` |

**Logo:** `frontend/src/assets/xact.svg`
**Sidebar collapse:** Jira-style double chevron (top-right of sidebar, desktop only)
**Sign out:** Bottom of sidebar above user profile
**User avatar:** Persisted in `localStorage` key `pp_avatar` — survives logout

---

## Real schema — important column names

These differ from what you might guess. Always check these:

| Table | PK | Notes |
|-------|----|-------|
| `dl01_mast` | `dl_code VARCHAR(8)` | `cr_status` values: GOOD/HOLD/COD |
| `st01_mast` | `stk_code VARCHAR(16)` | descriptions: `desc_1` through `desc_6` |
| `cl01_mast` | `cl_code VARCHAR(8)` | has `bank_name`, `branch_code`, `acct_no` |
| `gl01_mast` | `gl_code VARCHAR(8)` | column is `descr` NOT `description` |
| `gl02_loc_mast` | `(loc, whs)` composite | uses `@IdClass(Gl02LocMastId.class)`, 60+ columns |

---

## Git repository

- Remote: `https://github.com/xact-aneleg/patners_portal.git`
- Branch: `main`
- `.gitignore` excludes: `backend/target/`, `frontend/node_modules/`, `frontend/dist/`, `.idea/`, `application.properties`

```cmd
cd "C:\Users\user\Documents\Anele\Spring Boot Projects\XactERP_Complete\sy195"
git add .
git commit -m "description"
git push
```

---

## Known issues & fixes applied

| Issue | Fix |
|-------|-----|
| CORS blocking API calls | CORS moved into SecurityConfig (not separate CorsConfig) |
| Login fails from other devices | portalApi.js + bulkApi.js use `window.location.hostname` dynamically |
| Profile picture lost on logout | Avatar stored in `localStorage` key `pp_avatar`, NOT cleared on logout |
| LookupField import error | Use default import `import LookupField from` not named `import { LookupField }` |
| Table counts not showing | ConversionPage uses individual `.catch()` per module so one failure doesn't block others |
| Mobile layout broken | All pages use `MobilePage.module.css` + `Portal.module.css` with mobile-first CSS |

---

## Common commands

```cmd
rem Kill backend
taskkill /F /IM java.exe

rem Kill frontend
taskkill /F /IM node.exe

rem Find what is using port 8080
netstat -ano | findstr :8080

rem Reset demo passwords
curl http://localhost:8080/api/portal/auth/reset-demo-passwords
rem OR open in browser: http://localhost:8080/api/portal/auth/reset-demo-passwords
```
