-- ============================================================
-- sy195 + Partner Portal — database setup
-- ============================================================
--
-- SETUP ORDER (run these commands once):
--
--   Step 1: Create the database
--     psql -U postgres -c "CREATE DATABASE xactdev;"
--
--   Step 2: Apply the full real XactERP schema (510 tables)
--     psql -U postgres -d xactdev -f xactdev_schema_clean.sql
--
--   Step 3: Apply this file (adds the 6 Partner Portal tables)
--     psql -U postgres -d xactdev -f schema.sql
--
--   Step 4: Start the backend, then call:
--     http://localhost:8080/api/portal/auth/reset-demo-passwords
--
-- ============================================================

-- ── Partner Portal tables ─────────────────────────────────────────────────────
-- These 6 tables are additional to the xactdev_db schema.
-- They power the channel partner registration and approval workflow.

CREATE TABLE IF NOT EXISTS public.pp_partners (
    id              SERIAL          PRIMARY KEY,
    company_name    VARCHAR(100)    NOT NULL,
    contact_name    VARCHAR(80)     NOT NULL,
    email           VARCHAR(100)    NOT NULL UNIQUE,
    phone           VARCHAR(30),
    password_hash   VARCHAR(255)    NOT NULL,
    role            VARCHAR(20)     NOT NULL DEFAULT 'PARTNER',
    -- PARTNER | XACT_ADMIN | IMPLY
    active          BOOLEAN         DEFAULT TRUE,
    created_at      TIMESTAMP       DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pp_registrations (
    id                  SERIAL          PRIMARY KEY,
    partner_id          INTEGER         NOT NULL REFERENCES public.pp_partners(id),
    -- Package
    package_type        VARCHAR(10)     NOT NULL,           -- LITE | PRO
    num_users           INTEGER         NOT NULL DEFAULT 1,
    standalone          BOOLEAN         DEFAULT TRUE,
    master_company      VARCHAR(100),
    sync_modules        VARCHAR(100),
    -- Company details (maps to sy00_co_mast)
    company_name        VARCHAR(100)    NOT NULL,
    master_or_slave     VARCHAR(10)     DEFAULT 'MASTER',
    postal_addr1        VARCHAR(60),
    postal_addr2        VARCHAR(60),
    postal_addr3        VARCHAR(60),
    postal_addr4        VARCHAR(60),
    physical_addr1      VARCHAR(60),
    physical_addr2      VARCHAR(60),
    physical_addr3      VARCHAR(60),
    physical_addr4      VARCHAR(60),
    telephone           VARCHAR(30),
    fax                 VARCHAR(30),
    company_email       VARCHAR(100),
    company_domain      VARCHAR(100),
    reg_number          VARCHAR(30),
    vat_number          VARCHAR(30),
    year_end_month      INTEGER,
    vat_rate            NUMERIC(5,2)    DEFAULT 15,
    bank_name           VARCHAR(60),
    bank_branch         VARCHAR(60),
    bank_branch_code    VARCHAR(20),
    bank_account        VARCHAR(30),
    multi_currency      BOOLEAN         DEFAULT FALSE,
    local_currency      VARCHAR(40),
    currency_code       VARCHAR(6),
    -- Periods (current period per module at time of registration)
    period_gl           INTEGER,
    period_cb           INTEGER,
    period_dl           INTEGER,
    period_sa           INTEGER,
    period_cl           INTEGER,
    period_pu           INTEGER,
    system_year_end     INTEGER,
    -- Workflow
    status              VARCHAR(40)     NOT NULL DEFAULT 'DRAFT',
    -- DRAFT | PENDING_IMPLY | PENDING_XACT | APPROVED
    -- DECLINED_IMPLY | DECLINED_XACT | CONVERTING | LIVE
    decline_reason      TEXT,
    submitted_at        TIMESTAMP,
    created_at          TIMESTAMP       DEFAULT NOW(),
    updated_at          TIMESTAMP       DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pp_reg_locations (
    id                  SERIAL          PRIMARY KEY,
    registration_id     INTEGER         NOT NULL
                            REFERENCES public.pp_registrations(id) ON DELETE CASCADE,
    -- Maps to gl02_loc_mast (loc, whs)
    loc                 VARCHAR(3),
    whs                 VARCHAR(3),
    loc_name            VARCHAR(60),
    region              VARCHAR(40),
    stock_loc           BOOLEAN         DEFAULT FALSE,
    physical_addr1      VARCHAR(60),
    physical_addr2      VARCHAR(60),
    physical_addr3      VARCHAR(60),
    physical_addr4      VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS public.pp_reg_users (
    id                  SERIAL          PRIMARY KEY,
    registration_id     INTEGER         NOT NULL
                            REFERENCES public.pp_registrations(id) ON DELETE CASCADE,
    -- Maps to sy02_user
    username            VARCHAR(30),
    full_name           VARCHAR(80),
    email               VARCHAR(100),
    default_loc         VARCHAR(3),
    access_grp          VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS public.pp_workflow_events (
    id                  SERIAL          PRIMARY KEY,
    registration_id     INTEGER         NOT NULL
                            REFERENCES public.pp_registrations(id),
    actor_id            INTEGER
                            REFERENCES public.pp_partners(id),
    actor_name          VARCHAR(80),
    event_type          VARCHAR(40)     NOT NULL,
    -- SUBMITTED | APPROVED_IMPLY | DECLINED_IMPLY
    -- APPROVED_XACT | DECLINED_XACT | CONVERSION_STARTED | LIVE
    from_status         VARCHAR(40),
    to_status           VARCHAR(40),
    comments            TEXT,
    created_at          TIMESTAMP       DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pp_conversion_jobs (
    id                  SERIAL          PRIMARY KEY,
    registration_id     INTEGER         NOT NULL
                            REFERENCES public.pp_registrations(id),
    status              VARCHAR(20)     DEFAULT 'PENDING',
    -- PENDING | RUNNING | COMPLETE | FAILED
    started_at          TIMESTAMP,
    completed_at        TIMESTAMP,
    log_output          TEXT,
    created_at          TIMESTAMP       DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pp_reg_documents (
    id              BIGSERIAL       PRIMARY KEY,
    registration_id INTEGER         NOT NULL REFERENCES public.pp_registrations(id) ON DELETE CASCADE,
    file_name       VARCHAR(255)    NOT NULL,
    content_type    VARCHAR(100),
    file_size       BIGINT,
    file_data       BYTEA           NOT NULL,
    uploaded_by     VARCHAR(255),
    uploaded_at     TIMESTAMP       DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.pp_notifications (
    id              BIGSERIAL       PRIMARY KEY,
    recipient_id    INTEGER         NOT NULL REFERENCES public.pp_partners(id) ON DELETE CASCADE,
    registration_id INTEGER         REFERENCES public.pp_registrations(id) ON DELETE CASCADE,
    type            VARCHAR(50)     NOT NULL,
    message         TEXT            NOT NULL,
    is_read         BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMP       DEFAULT NOW()
);

-- ── Seed demo portal users ────────────────────────────────────────────────────
-- All three accounts use password: password123
-- After first backend start, call this URL to fix BCrypt hashes:
--   http://localhost:8080/api/portal/auth/reset-demo-passwords

INSERT INTO public.pp_partners (company_name, contact_name, email, password_hash, role)
VALUES
  ('Acme Resellers (Pty) Ltd', 'Anele Bhengu',  'partner@acme.co.za',  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LjZeUEHSQ0y', 'PARTNER'),
  ('XactERP Operations',       'Admin User',     'admin@xacterp.co.za', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LjZeUEHSQ0y', 'XACT_ADMIN'),
  ('Imply (Pty) Ltd',          'Imply Approver', 'approver@imply.co.za','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LjZeUEHSQ0y', 'IMPLY')
ON CONFLICT (email) DO NOTHING;
