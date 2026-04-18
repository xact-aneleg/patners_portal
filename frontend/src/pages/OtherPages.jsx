import React, { useState, useEffect } from 'react'
import { Button, Card, Field, FieldGrid, Divider, Toast, UploadZone, ResultsTable, ExportIcon, ImportIcon, TemplateIcon } from '../components/Components.jsx'
import LookupField from '../components/LookupField.jsx'
import api from '../api/bulkApi.js'
import styles from './pages.module.css'

// ── Creditors ─────────────────────────────────────────────────────────────────

const DEFAULT_CL = {
  startAcct: '!', endAcct: '~',
  masterAccount: 'A',
  filterController: false, startController: '', endController: '~~~',
  filterCat: false, startCat: '', endCat: '~~~',
  status: 'ALL', foreignTracked: 'ALL', interCo: 'ALL', importAccts: 'ALL',
}

export function CreditorsPage() {
  const [filters, setFilters]       = useState(DEFAULT_CL)
  const [toast, setToast]           = useState(null)
  const [exporting, setExporting]   = useState(false)
  const [showUpload, setShowUpload] = useState(false)
  const [dragActive, setDragActive] = useState(false)
  const [results, setResults]       = useState(null)

  // On mount: first cl_code (ASC) → startAcct, last cl_code (DESC) → endAcct
  useEffect(() => {
    api.getCodeRange('creditors').then(({ first, last }) => {
      setFilters(f => ({ ...f, startAcct: first, endAcct: last }))
    })
  }, [])

  const set = (key, val) => setFilters(f => ({ ...f, [key]: val }))

  const handleExport = async () => {
    setExporting(true); setToast(null)
    try {
      await api.exportModule('creditors', filters)
      setToast({ type: 'success', msg: 'Export ready — cl01_mast.xlsx is downloading.' })
    } catch (e) {
      setToast({ type: 'error', msg: 'Export failed: ' + (e.response?.data?.message || e.message) })
    } finally { setExporting(false) }
  }

  const handleFile = async (file) => {
    const data = await api.importModule('creditors', file)
    setResults(data.results)
    setToast(data.errors === 0
      ? { type: 'success', msg: `Import complete — ${data.imported} record(s) saved.` }
      : { type: 'error', msg: `Import finished with ${data.errors} error(s). See results below.` })
  }

  return (
    <div>
      {toast && <Toast type={toast.type} message={toast.msg} onDismiss={() => setToast(null)} />}

      <Card title="Account range">
        <FieldGrid cols={2}>
          {/* Start = first cl_code (ASC), End = last cl_code (DESC) */}
          <LookupField label="Start account" value={filters.startAcct}
            onChange={v => set('startAcct', v)} module="creditors" placeholder="Start account code…" />
          <LookupField label="End account" value={filters.endAcct}
            onChange={v => set('endAcct', v)} module="creditors" placeholder="End account code…" />
        </FieldGrid>

        <Divider label="Filters" />

        <FieldGrid cols={3}>
          <Field label="Account type">
            <select value={filters.masterAccount} onChange={e => set('masterAccount', e.target.value)}>
              <option value="A">All accounts</option>
              <option value="M">Master accounts only</option>
              <option value="S">Sub-accounts only</option>
              <option value="E">Exclude masters</option>
            </select>
          </Field>
          <Field label="Status">
            <select value={filters.status} onChange={e => set('status', e.target.value)}>
              <option value="ALL">All</option>
              <option value="A">Active only</option>
              <option value="B">Blocked only</option>
            </select>
          </Field>
          <Field label="Currency tracking">
            <select value={filters.foreignTracked} onChange={e => set('foreignTracked', e.target.value)}>
              <option value="ALL">All</option>
              <option value="E">Local currency only</option>
              <option value="F">Foreign currency tracked</option>
            </select>
          </Field>
          <Field label="Inter-company">
            <select value={filters.interCo} onChange={e => set('interCo', e.target.value)}>
              <option value="ALL">All</option>
              <option value="Y">Inter-company only</option>
              <option value="N">Exclude inter-company</option>
            </select>
          </Field>
          <Field label="Import accounts">
            <select value={filters.importAccts} onChange={e => set('importAccts', e.target.value)}>
              <option value="ALL">All</option>
              <option value="Y">Import accounts only</option>
              <option value="N">Exclude import accounts</option>
            </select>
          </Field>
        </FieldGrid>
      </Card>

      <Card>
        <div className={styles.actionBar}>
          <Button variant="primary" icon={<ExportIcon />} loading={exporting} onClick={handleExport}>Export with filters</Button>
          <Button variant="secondary" icon={<TemplateIcon />} onClick={() => api.downloadTemplate('creditors')}>Download template</Button>
          <div className={styles.actionSpacer} />
          <Button variant="secondary" icon={<ImportIcon />} onClick={() => { setShowUpload(v => !v); setResults(null) }}>
            {showUpload ? 'Hide import' : 'Import file'}
          </Button>
        </div>
        {showUpload && <UploadZone onFile={handleFile} dragActive={dragActive} setDragActive={setDragActive} />}
        <ResultsTable results={results} />
      </Card>
    </div>
  )
}

// ── General Ledger ────────────────────────────────────────────────────────────

const DEFAULT_GL = {
  startCode: '!', endCode: '~',
  status: 'ALL', acctType: 'A', postSubTot: 'A', budgetBasedOn: 'ALL',
}

export function GLPage() {
  const [filters, setFilters]       = useState(DEFAULT_GL)
  const [toast, setToast]           = useState(null)
  const [exporting, setExporting]   = useState(false)
  const [showUpload, setShowUpload] = useState(false)
  const [dragActive, setDragActive] = useState(false)
  const [results, setResults]       = useState(null)

  // On mount: first gl_code (ASC) → startCode, last gl_code (DESC) → endCode
  useEffect(() => {
    api.getCodeRange('gl').then(({ first, last }) => {
      setFilters(f => ({ ...f, startCode: first, endCode: last }))
    })
  }, [])

  const set = (key, val) => setFilters(f => ({ ...f, [key]: val }))

  const handleExport = async () => {
    setExporting(true); setToast(null)
    try {
      await api.exportModule('gl', filters)
      setToast({ type: 'success', msg: 'Export ready — gl01_mast.xlsx is downloading.' })
    } catch (e) {
      setToast({ type: 'error', msg: 'Export failed: ' + (e.response?.data?.message || e.message) })
    } finally { setExporting(false) }
  }

  const handleFile = async (file) => {
    const data = await api.importModule('gl', file)
    setResults(data.results)
    setToast(data.errors === 0
      ? { type: 'success', msg: `Import complete — ${data.imported} record(s) saved.` }
      : { type: 'error', msg: `Import finished with ${data.errors} error(s). See results below.` })
  }

  return (
    <div>
      {toast && <Toast type={toast.type} message={toast.msg} onDismiss={() => setToast(null)} />}

      <Card title="GL code range">
        <FieldGrid cols={2}>
          {/* Start = first gl_code (ASC), End = last gl_code (DESC) */}
          <LookupField label="Start GL code" value={filters.startCode}
            onChange={v => set('startCode', v)} module="gl" placeholder="Start GL code…" />
          <LookupField label="End GL code" value={filters.endCode}
            onChange={v => set('endCode', v)} module="gl" placeholder="End GL code…" />
        </FieldGrid>

        <Divider label="Filters" />

        <FieldGrid cols={2}>
          <Field label="Status">
            <select value={filters.status} onChange={e => set('status', e.target.value)}>
              <option value="ALL">All</option>
              <option value="A">Active only</option>
              <option value="B">Blocked only</option>
            </select>
          </Field>
          <Field label="Account type">
            <select value={filters.acctType} onChange={e => set('acctType', e.target.value)}>
              <option value="A">All types</option>
              <option value="B">Balance sheet</option>
              <option value="P">Profit &amp; loss</option>
            </select>
          </Field>
          <Field label="Post / sub-total">
            <select value={filters.postSubTot} onChange={e => set('postSubTot', e.target.value)}>
              <option value="A">All</option>
              <option value="P">Posting accounts</option>
              <option value="S">Sub-totals only</option>
            </select>
          </Field>
          <Field label="Budget based on">
            <select value={filters.budgetBasedOn} onChange={e => set('budgetBasedOn', e.target.value)}>
              <option value="ALL">All</option>
              <option value="S">Sales</option>
              <option value="C">Cost</option>
              <option value="E">Expenditure</option>
              <option value="B">Balance</option>
            </select>
          </Field>
        </FieldGrid>
      </Card>

      <Card>
        <div className={styles.actionBar}>
          <Button variant="primary" icon={<ExportIcon />} loading={exporting} onClick={handleExport}>Export with filters</Button>
          <Button variant="secondary" icon={<TemplateIcon />} onClick={() => api.downloadTemplate('gl')}>Download template</Button>
          <div className={styles.actionSpacer} />
          <Button variant="secondary" icon={<ImportIcon />} onClick={() => { setShowUpload(v => !v); setResults(null) }}>
            {showUpload ? 'Hide import' : 'Import file'}
          </Button>
        </div>
        {showUpload && <UploadZone onFile={handleFile} dragActive={dragActive} setDragActive={setDragActive} />}
        <ResultsTable results={results} />
      </Card>
    </div>
  )
}
