import React, { useState, useEffect } from 'react'
import api from '../api/bulkApi.js'
import s from './MobilePage.module.css'

const MODULES = [
  { id:'debtors',   label:'Debtors',      table:'dl01_mast' },
  { id:'stock',     label:'Stock',         table:'st01_mast' },
  { id:'creditors', label:'Creditors',     table:'cl01_mast' },
  { id:'gl',        label:'GL accounts',   table:'gl01_mast' },
]

export default function ConversionPage() {
  const [counts,   setCounts]   = useState({})
  const [selected, setSelected] = useState('debtors')
  const [empty,    setEmpty]    = useState(false)
  const [busy,     setBusy]     = useState(false)
  const [file,     setFile]     = useState(null)
  const [toast,    setToast]    = useState(null)

  useEffect(() => {
    // Load counts for all modules
    MODULES.forEach(m => {
      api.getCount(m.id)
        .then(n => setCounts(c => ({...c, [m.id]: n})))
        .catch(() => setCounts(c => ({...c, [m.id]: '?'})))
    })
  }, [])

  async function doExport() {
    setBusy(true)
    try {
      const mod  = MODULES.find(m => m.id === selected)
      const blob = await api.conversionExport(selected)
      const a    = document.createElement('a')
      a.href     = URL.createObjectURL(blob)
      a.download = mod.table + '_full.xlsx'
      a.click()
      setToast({ ok:true, msg:'Full export downloaded' })
    } catch { setToast({ ok:false, msg:'Export failed' }) }
    finally { setBusy(false) }
  }

  async function doImport() {
    if (!file) { setToast({ ok:false, msg:'Select a file first' }); return }
    if (empty && !window.confirm(
      `This will DELETE all rows in ${selected} before importing. Continue?`
    )) return
    setBusy(true)
    try {
      const data = await api.conversionImport(file, selected, empty)
      setToast({ ok:true, msg:`Imported ${data.imported ?? '?'} rows` })
      // Refresh count for this module
      api.getCount(selected)
        .then(n => setCounts(c => ({...c, [selected]: n})))
        .catch(() => {})
    } catch { setToast({ ok:false, msg:'Import failed' }) }
    finally { setBusy(false) }
  }

  const mod = MODULES.find(m => m.id === selected)

  return (
    <div className={s.page}>
      {toast && (
        <div className={`${s.toast} ${toast.ok ? s.toastOk : s.toastErr}`}>
          {toast.msg}
          <button onClick={() => setToast(null)}>×</button>
        </div>
      )}

      {/* Stat cards — click to select module */}
      <div className={s.statGrid}>
        {MODULES.map(m => (
          <div key={m.id}
            className={`${s.statCard} ${selected === m.id ? s.statCardActive : ''}`}
            onClick={() => setSelected(m.id)}>
            <div className={s.statNum}>
              {counts[m.id] !== undefined ? counts[m.id] : '…'}
            </div>
            <div className={s.statLbl}>{m.label}</div>
            <div className={s.statTable}>{m.table}</div>
          </div>
        ))}
      </div>

      {/* Selected module actions */}
      <div className={s.card}>
        <div className={s.cardTitle}>
          {mod?.label} — {mod?.table}
        </div>

        {/* Export */}
        <div className={s.actions} style={{ marginBottom: 16 }}>
          <button className={s.btnOutline} onClick={doExport} disabled={busy}>
            ↓ Full export ({counts[selected] !== undefined ? counts[selected] : '…'} rows)
          </button>
        </div>

        <div className={s.sbDivider} style={{ margin:'0 0 16px' }}/>

        {/* Empty table option */}
        <label className={s.checkLabel} style={{ marginBottom: 12 }}>
          <input
            type="checkbox"
            checked={empty}
            onChange={e => setEmpty(e.target.checked)}
            style={{ width:18, height:18, accentColor:'#dc3545' }}
          />
          <span style={{ color: empty ? '#dc3545' : '#1a2733', fontWeight: empty ? 700 : 400 }}>
            Empty table before importing
          </span>
        </label>
        {empty && (
          <p style={{ fontSize:12, color:'#dc3545', marginBottom:12, padding:'8px 12px', background:'#fff5f5', borderRadius:6, border:'1px solid #f5c6cb' }}>
            ⚠ All existing rows in {mod?.table} will be permanently deleted before import
          </p>
        )}

        {/* File drop zone */}
        <div
          className={`${s.dropZone} ${file ? s.dropZoneHasFile : ''}`}
          onClick={() => document.getElementById('convfile').click()}
        >
          <input id="convfile" type="file" accept=".xlsx,.xls,.csv"
            style={{ display:'none' }} onChange={e => setFile(e.target.files[0])} />
          {file
            ? <><div className={s.dropIcon}>✓</div><div className={s.dropText}>{file.name}</div></>
            : <><div className={s.dropIcon}>↑</div>
                <div className={s.dropText}>Tap to select import file</div>
                <div className={s.dropHint}>.xlsx .xls .csv</div></>
          }
        </div>
      </div>

      <div className={s.actions}>
        <button
          className={empty ? s.btnDanger : s.btnPrimary}
          onClick={doImport}
          disabled={busy || !file}>
          {busy ? 'Importing…' : empty ? '⚠ Empty & Import' : '↑ Import'}
        </button>
        {file && (
          <button className={s.btnOutline} onClick={() => setFile(null)}>✕ Clear</button>
        )}
      </div>
    </div>
  )
}
