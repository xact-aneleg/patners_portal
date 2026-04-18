import React, { useState, useEffect } from 'react'
import { Button, Card, Field, FieldGrid, Divider, Toast, UploadZone, ResultsTable, ExportIcon, ImportIcon, TemplateIcon } from '../components/Components.jsx'
import LookupField from '../components/LookupField.jsx'
import api from '../api/bulkApi.js'
import styles from './pages.module.css'

const PLACEHOLDER = { startAcct: '!', endAcct: '~' }

const DEFAULT_FILTERS = {
  startAcct: '!', endAcct: '~',
  masterAcct: 'A', delAcct: 'A',
  sortByLoc: false, locSelect: 'R',
  startLoc: '', endLoc: '~~~',
  filterCat: false, startCat: '', endCat: '~~~',
  filterRep: false, repType: 'R', startRep: '', endRep: '~~~',
  status: 'ALL', invType: 'ALL', crStatus: 'ALL',
  balance: 'ALL', foreignTracked: 'ALL',
}

export default function DebtorsPage() {
  const [filters, setFilters]       = useState(DEFAULT_FILTERS)
  const [toast, setToast]           = useState(null)
  const [importing, setImporting]   = useState(false)
  const [exporting, setExporting]   = useState(false)
  const [showUpload, setShowUpload] = useState(false)
  const [dragActive, setDragActive] = useState(false)
  const [results, setResults]       = useState(null)

  // On mount: fetch the first and last dl_code from the database
  // and set them as the default start/end account values
  useEffect(() => {
    api.getCodeRange('debtors').then(({ first, last }) => {
      setFilters(f => ({ ...f, startAcct: first, endAcct: last }))
    })
  }, [])

  const set = (key, val) => setFilters(f => ({ ...f, [key]: val }))

  const handleExport = async () => {
    setExporting(true); setToast(null)
    try {
      await api.exportModule('debtors', filters)
      setToast({ type: 'success', msg: 'Export ready — dl01_mast.xlsx is downloading.' })
    } catch (e) {
      setToast({ type: 'error', msg: 'Export failed: ' + (e.response?.data?.message || e.message) })
    } finally { setExporting(false) }
  }

  const handleTemplate = async () => {
    try { await api.downloadTemplate('debtors') }
    catch { setToast({ type: 'error', msg: 'Template download failed.' }) }
  }

  const handleFile = async (file) => {
    setImporting(true); setResults(null); setToast(null)
    try {
      const data = await api.importModule('debtors', file)
      setResults(data.results)
      if (data.errors === 0) {
        setToast({ type: 'success', msg: `Import complete — ${data.imported} record(s) saved.` })
      } else {
        setToast({ type: 'error', msg: `Import finished with ${data.errors} error(s). See results below.` })
      }
    } catch (e) {
      setToast({ type: 'error', msg: 'Import failed: ' + (e.response?.data?.message || e.message) })
    } finally { setImporting(false) }
  }

  return (
    <div>
      {toast && <Toast type={toast.type} message={toast.msg} onDismiss={() => setToast(null)} />}

      <Card title="Account range">
        <FieldGrid cols={2}>
          {/* Start account = first dl_code in dl01_mast (ORDER BY dl_code ASC LIMIT 1) */}
          <LookupField label="Start account" value={filters.startAcct}
            onChange={v => set('startAcct', v)} module="debtors" placeholder="Start account code…" />
          {/* End account = last dl_code in dl01_mast (ORDER BY dl_code DESC LIMIT 1) */}
          <LookupField label="End account" value={filters.endAcct}
            onChange={v => set('endAcct', v)} module="debtors" placeholder="End account code…" />
        </FieldGrid>

        <Divider label="Account filters" />

        <FieldGrid cols={3}>
          <Field label="Account type">
            <select value={filters.masterAcct} onChange={e => set('masterAcct', e.target.value)}>
              <option value="A">All accounts</option>
              <option value="M">Master accounts only</option>
              <option value="S">Sub-accounts only</option>
              <option value="E">Exclude masters</option>
            </select>
          </Field>
          <Field label="Delivery account">
            <select value={filters.delAcct} onChange={e => set('delAcct', e.target.value)}>
              <option value="A">All</option>
              <option value="D">Delivery accounts only</option>
              <option value="E">Exclude delivery accounts</option>
            </select>
          </Field>
          <Field label="Credit status">
            <select value={filters.crStatus} onChange={e => set('crStatus', e.target.value)}>
              <option value="ALL">All statuses</option>
              <option value="G">Good</option>
              <option value="H">Hold</option>
              <option value="C">COD</option>
              <option value="P">POS</option>
            </select>
          </Field>
          <Field label="Invoice type">
            <select value={filters.invType} onChange={e => set('invType', e.target.value)}>
              <option value="ALL">All types</option>
              <option value="TAX">Tax invoice</option>
              <option value="CASH">Cash</option>
            </select>
          </Field>
          <Field label="Record status">
            <select value={filters.status} onChange={e => set('status', e.target.value)}>
              <option value="ALL">Active + blocked</option>
              <option value="A">Active only</option>
              <option value="B">Blocked only</option>
            </select>
          </Field>
          <Field label="Balance">
            <select value={filters.balance} onChange={e => set('balance', e.target.value)}>
              <option value="ALL">All</option>
              <option value="B">Non-zero balance</option>
              <option value="Z">Zero balance</option>
            </select>
          </Field>
          <Field label="Currency tracking">
            <select value={filters.foreignTracked} onChange={e => set('foreignTracked', e.target.value)}>
              <option value="ALL">All</option>
              <option value="E">Local currency only</option>
              <option value="F">Foreign currency tracked</option>
            </select>
          </Field>
        </FieldGrid>

        <Divider label="Location" />

        <FieldGrid cols={3}>
          <Field label="Filter by location">
            <select value={filters.sortByLoc ? 'Y' : 'N'} onChange={e => set('sortByLoc', e.target.value === 'Y')}>
              <option value="N">No location filter</option>
              <option value="Y">Filter by location</option>
            </select>
          </Field>
          {filters.sortByLoc && (
            <Field label="Selection method">
              <select value={filters.locSelect} onChange={e => set('locSelect', e.target.value)}>
                <option value="R">Range</option>
                <option value="I">Individual locations</option>
              </select>
            </Field>
          )}
          {filters.sortByLoc && (
            <Field label={filters.locSelect === 'I' ? 'Locations (comma-separated)' : 'Start location'}>
              <input value={filters.startLoc} onChange={e => set('startLoc', e.target.value)} placeholder="e.g. 001" />
            </Field>
          )}
          {filters.sortByLoc && filters.locSelect === 'R' && (
            <Field label="End location">
              <input value={filters.endLoc} onChange={e => set('endLoc', e.target.value)} placeholder="e.g. 099" />
            </Field>
          )}
        </FieldGrid>
      </Card>

      <Card>
        <div className={styles.actionBar}>
          <Button variant="primary" icon={<ExportIcon />} loading={exporting} onClick={handleExport}>
            Export with filters
          </Button>
          <Button variant="secondary" icon={<TemplateIcon />} onClick={handleTemplate}>
            Download template
          </Button>
          <div className={styles.actionSpacer} />
          <Button variant="secondary" icon={<ImportIcon />} onClick={() => { setShowUpload(v => !v); setResults(null) }}>
            {showUpload ? 'Hide import' : 'Import file'}
          </Button>
        </div>
        {showUpload && <UploadZone onFile={handleFile} dragActive={dragActive} setDragActive={setDragActive} />}
        {importing && <p className={styles.importingMsg}>Importing…</p>}
        <ResultsTable results={results} />
      </Card>
    </div>
  )
}
