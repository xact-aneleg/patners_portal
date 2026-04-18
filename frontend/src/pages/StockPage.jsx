import React, { useState, useEffect } from 'react'
import { Button, Card, Field, FieldGrid, Divider, Toast, UploadZone, ResultsTable, ExportIcon, ImportIcon, TemplateIcon } from '../components/Components.jsx'
import LookupField from '../components/LookupField.jsx'
import api from '../api/bulkApi.js'
import styles from './pages.module.css'

const DEFAULT_FILTERS = {
  startStkCode: '!', endStkCode: '~',
  masterAcct: 'A', stkSelection: 'C',
  startDiv: '', endDiv: '~~~',
  startSection: '', endSection: '~~~',
  startStkGrp: '', endStkGrp: '~~~',
  startSubGrp: '', endSubGrp: '~~~',
  webEnabled: 'ALL', retailEnabled: 'ALL',
  tradeInItems: 'ALL', importItems: 'ALL',
  keepBalance: 'ALL', status: 'ALL',
}

const STK_SEL_LABELS = { G: 'stock group', SG: 'sub-group', S: 'section', D: 'division' }

function getRangeKeys(sel) {
  return {
    start: sel === 'G' ? 'startStkGrp' : sel === 'SG' ? 'startSubGrp' : sel === 'S' ? 'startSection' : 'startDiv',
    end:   sel === 'G' ? 'endStkGrp'   : sel === 'SG' ? 'endSubGrp'   : sel === 'S' ? 'endSection'   : 'endDiv',
  }
}

export default function StockPage() {
  const [filters, setFilters]       = useState(DEFAULT_FILTERS)
  const [toast, setToast]           = useState(null)
  const [exporting, setExporting]   = useState(false)
  const [importing, setImporting]   = useState(false)
  const [showUpload, setShowUpload] = useState(false)
  const [dragActive, setDragActive] = useState(false)
  const [results, setResults]       = useState(null)

  // On mount: fetch the first and last stk_code (ORDER BY stk_code ASC/DESC LIMIT 1)
  useEffect(() => {
    api.getCodeRange('stock').then(({ first, last }) => {
      setFilters(f => ({ ...f, startStkCode: first, endStkCode: last }))
    })
  }, [])

  const set = (key, val) => setFilters(f => ({ ...f, [key]: val }))
  const showRange = filters.stkSelection !== 'C'
  const { start: startKey, end: endKey } = getRangeKeys(filters.stkSelection)

  const handleExport = async () => {
    setExporting(true); setToast(null)
    try {
      await api.exportModule('stock', filters)
      setToast({ type: 'success', msg: 'Export ready — st01_mast.xlsx is downloading.' })
    } catch (e) {
      setToast({ type: 'error', msg: 'Export failed: ' + (e.response?.data?.message || e.message) })
    } finally { setExporting(false) }
  }

  const handleFile = async (file) => {
    setImporting(true); setResults(null); setToast(null)
    try {
      const data = await api.importModule('stock', file)
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

      <Card title="Stock code range">
        <FieldGrid cols={2}>
          {/* Start = first stk_code (ASC), End = last stk_code (DESC) */}
          <LookupField label="Start stock code" value={filters.startStkCode}
            onChange={v => set('startStkCode', v)} module="stock" placeholder="Start stock code…" />
          <LookupField label="End stock code" value={filters.endStkCode}
            onChange={v => set('endStkCode', v)} module="stock" placeholder="End stock code…" />
        </FieldGrid>

        <Divider label="Selection" />

        <FieldGrid cols={3}>
          <Field label="Select by">
            <select value={filters.stkSelection} onChange={e => set('stkSelection', e.target.value)}>
              <option value="C">All codes</option>
              <option value="G">Stock group</option>
              <option value="SG">Sub-group</option>
              <option value="S">Section</option>
              <option value="D">Division</option>
            </select>
          </Field>
          {showRange && (
            <Field label={`Start ${STK_SEL_LABELS[filters.stkSelection]}`}>
              <input value={filters[startKey] || ''} onChange={e => set(startKey, e.target.value)} />
            </Field>
          )}
          {showRange && (
            <Field label={`End ${STK_SEL_LABELS[filters.stkSelection]}`}>
              <input value={filters[endKey] || ''} onChange={e => set(endKey, e.target.value)} />
            </Field>
          )}
        </FieldGrid>

        <Divider label="Filters" />

        <FieldGrid cols={3}>
          <Field label="Status">
            <select value={filters.status} onChange={e => set('status', e.target.value)}>
              <option value="ALL">Active + blocked</option>
              <option value="A">Active only</option>
              <option value="B">Blocked only</option>
            </select>
          </Field>
          <Field label="Keep balance">
            <select value={filters.keepBalance} onChange={e => set('keepBalance', e.target.value)}>
              <option value="ALL">All</option>
              <option value="K">Keep balance = Y</option>
              <option value="E">Keep balance = N</option>
            </select>
          </Field>
          <Field label="Web enabled">
            <select value={filters.webEnabled} onChange={e => set('webEnabled', e.target.value)}>
              <option value="ALL">All</option>
              <option value="W">Web enabled only</option>
              <option value="E">Not web enabled</option>
            </select>
          </Field>
          <Field label="Retail enabled">
            <select value={filters.retailEnabled} onChange={e => set('retailEnabled', e.target.value)}>
              <option value="ALL">All</option>
              <option value="R">Retail enabled only</option>
              <option value="E">Not retail enabled</option>
            </select>
          </Field>
          <Field label="Trade-in items">
            <select value={filters.tradeInItems} onChange={e => set('tradeInItems', e.target.value)}>
              <option value="ALL">All</option>
              <option value="T">Trade-in items only</option>
              <option value="E">Exclude trade-in items</option>
            </select>
          </Field>
          <Field label="Import items">
            <select value={filters.importItems} onChange={e => set('importItems', e.target.value)}>
              <option value="ALL">All</option>
              <option value="IM">Import items only</option>
              <option value="E">Exclude import items</option>
            </select>
          </Field>
        </FieldGrid>
      </Card>

      <Card>
        <div className={styles.actionBar}>
          <Button variant="primary" icon={<ExportIcon />} loading={exporting} onClick={handleExport}>
            Export with filters
          </Button>
          <Button variant="secondary" icon={<TemplateIcon />} onClick={() => api.downloadTemplate('stock')}>
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
