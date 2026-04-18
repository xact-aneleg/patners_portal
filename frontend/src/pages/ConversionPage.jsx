import React, { useState, useEffect } from 'react'
import { Button, Card, Field, FieldGrid, Divider, Toast, UploadZone, ResultsTable, ExportIcon, ImportIcon } from '../components/Components.jsx'
import api from '../api/bulkApi.js'
import styles from './pages.module.css'
import convStyles from './ConversionPage.module.css'

const MODULES = [
  { id: 'debtors',   label: 'Debtors',       table: 'dl01_mast' },
  { id: 'stock',     label: 'Stock',         table: 'st01_mast' },
  { id: 'creditors', label: 'Creditors',     table: 'cl01_mast' },
  { id: 'gl',        label: 'General ledger',table: 'gl01_mast' },
]

export default function ConversionPage() {
  const [module,      setModule]      = useState('debtors')
  const [delimiter,   setDelimiter]   = useState(',')
  const [headerLine,  setHeaderLine]  = useState(1)
  const [emptyTable,  setEmptyTable]  = useState(false)
  const [toast,       setToast]       = useState(null)
  const [exporting,   setExporting]   = useState(false)
  const [importing,   setImporting]   = useState(false)
  const [showUpload,  setShowUpload]  = useState(false)
  const [dragActive,  setDragActive]  = useState(false)
  const [results,     setResults]     = useState(null)
  const [counts,      setCounts]      = useState({})

  // Load row counts for all modules on mount
  useEffect(() => {
    MODULES.forEach(m => {
      api.getConversionCount(m.id)
        .then(count => setCounts(prev => ({ ...prev, [m.id]: count })))
        .catch(() => {})
    })
  }, [results]) // refresh after import

  const selectedMod = MODULES.find(m => m.id === module)

  const handleExport = async () => {
    setExporting(true); setToast(null)
    try {
      await api.conversionExport(module)
      setToast({ type: 'success', msg: `Full export of ${selectedMod.table} is downloading.` })
    } catch (e) {
      setToast({ type: 'error', msg: 'Export failed: ' + (e.response?.data?.message || e.message) })
    } finally { setExporting(false) }
  }

  const handleFile = async (file) => {
    if (emptyTable) {
      const confirmed = window.confirm(
        `⚠️ WARNING: This will DELETE ALL rows in ${selectedMod.table} before importing.\n\nAre you sure you want to continue?`
      )
      if (!confirmed) return
    }
    setImporting(true); setResults(null); setToast(null)
    try {
      const data = await api.conversionImport(module, file, emptyTable, delimiter, headerLine)
      setResults(data.results)
      if (data.errors === 0) {
        setToast({ type: 'success', msg: `Conversion complete — ${data.imported} record(s) saved to ${selectedMod.table}.` })
      } else {
        setToast({ type: 'error', msg: `Conversion finished with ${data.errors} error(s). ${data.imported} record(s) saved.` })
      }
    } catch (e) {
      setToast({ type: 'error', msg: 'Import failed: ' + (e.response?.data?.message || e.message) })
    } finally { setImporting(false) }
  }

  return (
    <div>
      {toast && <Toast type={toast.type} message={toast.msg} onDismiss={() => setToast(null)} />}

      {/* Module stat cards */}
      <div className={convStyles.statGrid}>
        {MODULES.map(m => (
          <button
            key={m.id}
            className={`${convStyles.statCard} ${module === m.id ? convStyles.statCardActive : ''}`}
            onClick={() => { setModule(m.id); setResults(null); setShowUpload(false); setToast(null) }}
          >
            <span className={convStyles.statCount}>
              {counts[m.id] !== undefined ? counts[m.id].toLocaleString() : '—'}
            </span>
            <span className={convStyles.statLabel}>{m.label}</span>
            <span className={convStyles.statTable}>{m.table}</span>
          </button>
        ))}
      </div>

      {/* Config card */}
      <Card title="Conversion settings">
        <FieldGrid cols={3}>
          <Field label="Table">
            <select value={module} onChange={e => { setModule(e.target.value); setResults(null); setShowUpload(false) }}>
              {MODULES.map(m => (
                <option key={m.id} value={m.id}>{m.label} — {m.table}</option>
              ))}
            </select>
          </Field>
          <Field label="Field delimiter">
            <select value={delimiter} onChange={e => setDelimiter(e.target.value)}>
              <option value=",">, (comma)</option>
              <option value=";">; (semicolon)</option>
              <option value="|">| (pipe)</option>
              <option value={"\t"}>⇥ (tab)</option>
            </select>
          </Field>
          <Field label="Header row number">
            <select value={headerLine} onChange={e => setHeaderLine(Number(e.target.value))}>
              <option value={1}>Row 1</option>
              <option value={2}>Row 2</option>
              <option value={3}>Row 3</option>
            </select>
          </Field>
        </FieldGrid>

        <Divider label="Import options" />

        <div className={convStyles.emptyTableRow}>
          <label className={convStyles.checkLabel}>
            <input
              type="checkbox"
              checked={emptyTable}
              onChange={e => setEmptyTable(e.target.checked)}
              className={convStyles.checkbox}
            />
            <span className={convStyles.checkText}>
              Empty table before import
            </span>
          </label>
          {emptyTable && (
            <span className={convStyles.warningPill}>
              ⚠ All existing rows in {selectedMod?.table} will be deleted before import
            </span>
          )}
        </div>
      </Card>

      {/* Actions card */}
      <Card>
        <div className={styles.actionBar}>
          <Button variant="primary" icon={<ExportIcon />} loading={exporting} onClick={handleExport}>
            Export full table
          </Button>
          <div className={styles.actionSpacer} />
          <Button
            variant={emptyTable ? 'danger' : 'secondary'}
            icon={<ImportIcon />}
            onClick={() => { setShowUpload(v => !v); setResults(null) }}
          >
            {showUpload ? 'Hide import' : emptyTable ? 'Import (will empty table)' : 'Import file'}
          </Button>
        </div>

        {showUpload && (
          <UploadZone onFile={handleFile} dragActive={dragActive} setDragActive={setDragActive} />
        )}
        {importing && <p className={styles.importingMsg}>Converting…</p>}
        <ResultsTable results={results} />
      </Card>
    </div>
  )
}
