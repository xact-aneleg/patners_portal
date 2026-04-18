import React from 'react'
import styles from './components.module.css'

// ── Button ────────────────────────────────────────────────────────────────────

export function Button({ variant = 'secondary', children, loading, icon, ...props }) {
  return (
    <button
      className={`${styles.btn} ${styles[`btn_${variant}`]}`}
      disabled={loading || props.disabled}
      {...props}
    >
      {loading
        ? <span className={styles.spinner} aria-hidden="true" />
        : icon && <span className={styles.btnIcon} aria-hidden="true">{icon}</span>}
      {children}
    </button>
  )
}

// ── Badge ─────────────────────────────────────────────────────────────────────

export function Badge({ variant = 'default', children }) {
  return <span className={`${styles.badge} ${styles[`badge_${variant}`]}`}>{children}</span>
}

// ── Toast ─────────────────────────────────────────────────────────────────────

export function Toast({ type, message, onDismiss }) {
  if (!message) return null
  return (
    <div className={`${styles.toast} ${styles[`toast_${type}`]}`} role="alert">
      <span className={styles.toastIcon}>{type === 'success' ? <CheckIcon /> : <AlertIcon />}</span>
      <span className={styles.toastMsg}>{message}</span>
      <button className={styles.toastClose} onClick={onDismiss} aria-label="Dismiss">
        <CloseIcon />
      </button>
    </div>
  )
}

// ── Card ──────────────────────────────────────────────────────────────────────

export function Card({ title, children, actions }) {
  return (
    <div className={styles.card}>
      {title && (
        <div className={styles.cardHeader}>
          <span className={styles.cardDot} />
          <span className={styles.cardTitle}>{title}</span>
          {actions && <div className={styles.cardActions}>{actions}</div>}
        </div>
      )}
      <div className={styles.cardBody}>{children}</div>
    </div>
  )
}

// ── Field grid ────────────────────────────────────────────────────────────────

export function FieldGrid({ children, cols = 2 }) {
  return (
    <div className={styles.fieldGrid} style={{ gridTemplateColumns: `repeat(${cols}, minmax(0, 1fr))` }}>
      {children}
    </div>
  )
}

export function Field({ label, children, span }) {
  return (
    <div className={styles.field} style={span ? { gridColumn: `span ${span}` } : {}}>
      {label && <label>{label}</label>}
      {children}
    </div>
  )
}

// ── Divider ───────────────────────────────────────────────────────────────────

export function Divider({ label }) {
  return (
    <div className={styles.divider}>
      {label && <span className={styles.dividerLabel}>{label}</span>}
    </div>
  )
}

// ── Upload zone ───────────────────────────────────────────────────────────────

export function UploadZone({ onFile, dragActive, setDragActive }) {
  const inputRef = React.useRef(null)

  const handleDrop = (e) => {
    e.preventDefault()
    setDragActive(false)
    const file = e.dataTransfer.files?.[0]
    if (file) onFile(file)
  }

  const handleChange = (e) => {
    const file = e.target.files?.[0]
    if (file) onFile(file)
    e.target.value = ''
  }

  return (
    <div
      className={`${styles.uploadZone} ${dragActive ? styles.uploadZoneActive : ''}`}
      onClick={() => inputRef.current?.click()}
      onDragOver={(e) => { e.preventDefault(); setDragActive(true) }}
      onDragLeave={() => setDragActive(false)}
      onDrop={handleDrop}
      role="button"
      tabIndex={0}
      onKeyDown={(e) => e.key === 'Enter' && inputRef.current?.click()}
      aria-label="Upload XLSX file"
    >
      <input ref={inputRef} type="file" accept=".xlsx" onChange={handleChange} hidden />
      <div className={styles.uploadIcon}>
        <UploadSvg />
      </div>
      <p className={styles.uploadTitle}>Drop your XLSX file here</p>
      <p className={styles.uploadSub}>or <span className={styles.uploadLink}>click to browse</span> — accepts files exported from this tool</p>
    </div>
  )
}

// ── Import results table ──────────────────────────────────────────────────────

export function ResultsTable({ results }) {
  if (!results || results.length === 0) return null
  const ok  = results.filter(r => r.status === 'OK').length
  const err = results.filter(r => r.status === 'ERROR').length

  return (
    <div className={styles.results}>
      <div className={styles.resultsHeader}>
        <span className={styles.resultsTitle}>Import results</span>
        <Badge variant="success">{ok} imported</Badge>
        {err > 0 && <Badge variant="danger">{err} {err === 1 ? 'error' : 'errors'}</Badge>}
      </div>
      <div className={styles.tableWrap}>
        <table className={styles.table}>
          <thead>
            <tr>
              <th style={{ width: 52 }}>Row</th>
              <th style={{ width: 110 }}>Field</th>
              <th style={{ width: 130 }}>Key</th>
              <th>Message</th>
              <th style={{ width: 80 }}>Status</th>
            </tr>
          </thead>
          <tbody>
            {results.map((r, i) => (
              <tr key={i}>
                <td className={styles.mono}>{r.rowNumber}</td>
                <td className={styles.mono}>{r.fieldName}</td>
                <td className={styles.mono}>{r.keyField}</td>
                <td>{r.exception}</td>
                <td><Badge variant={r.status === 'OK' ? 'success' : 'danger'}>{r.status}</Badge></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

// ── Loading spinner ───────────────────────────────────────────────────────────

export function Spinner({ size = 16 }) {
  return (
    <svg className={styles.spinnerSvg} width={size} height={size} viewBox="0 0 24 24" fill="none">
      <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="2.5" opacity="0.25" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" />
    </svg>
  )
}

// ── SVG icons ─────────────────────────────────────────────────────────────────

export const ExportIcon = () => (
  <svg width="14" height="14" viewBox="0 0 16 16" fill="none">
    <path d="M8 2v8M5 7l3 3 3-3" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M3 12h10" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round"/>
  </svg>
)

export const ImportIcon = () => (
  <svg width="14" height="14" viewBox="0 0 16 16" fill="none">
    <path d="M8 10V2M5 5l3-3 3 3" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M3 12h10" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round"/>
  </svg>
)

export const TemplateIcon = () => (
  <svg width="14" height="14" viewBox="0 0 16 16" fill="none">
    <rect x="2" y="2" width="12" height="12" rx="2" stroke="currentColor" strokeWidth="1.4"/>
    <path d="M5 6h6M5 9h4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/>
  </svg>
)

const CheckIcon = () => (
  <svg width="15" height="15" viewBox="0 0 16 16" fill="none">
    <circle cx="8" cy="8" r="7" stroke="currentColor" strokeWidth="1.4"/>
    <path d="M5 8l2 2 4-4" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"/>
  </svg>
)

const AlertIcon = () => (
  <svg width="15" height="15" viewBox="0 0 16 16" fill="none">
    <circle cx="8" cy="8" r="7" stroke="currentColor" strokeWidth="1.4"/>
    <path d="M8 5v3.5M8 11h.01" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/>
  </svg>
)

const CloseIcon = () => (
  <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
    <path d="M2 2l10 10M12 2L2 12" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/>
  </svg>
)

const UploadSvg = () => (
  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
    <path d="M12 15V3M8 7l4-4 4 4" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/>
    <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round"/>
  </svg>
)
