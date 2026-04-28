import React, { useState, useEffect } from 'react'
import api from '../api/bulkApi.js'
import LookupField from '../components/LookupField.jsx'
import s from './MobilePage.module.css'

export default function DebtorsPage() {
  const [tab,     setTab]     = useState('export')
  const [busy,    setBusy]    = useState(false)
  const [toast,   setToast]   = useState(null)
  const [results, setResults] = useState(null)
  const [file,    setFile]    = useState(null)
  const [drag,    setDrag]    = useState(false)

  const [f, setF] = useState({
    startAcct:'!', endAcct:'~',
    masterAcct:'A', delAcct:'A',
    status:'ALL', crStatus:'ALL',
    balance:'ALL', foreignTracked:'ALL',
    filterCat:false, startCat:'', endCat:'~~~',
    filterRep:false, repType:'R', startRep:'', endRep:'~~~',
  })
  const set = (k,v) => setF(p => ({...p,[k]:v}))

  async function doExport() {
    setBusy(true); setToast(null)
    try {
      const blob = await api.exportModule('debtors', f)
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a'); a.href=url; a.download='dl01_mast.xlsx'; a.click()
      setToast({ok:true, msg:'Export downloaded successfully'})
    } catch { setToast({ok:false, msg:'Export failed'}) }
    finally { setBusy(false) }
  }

  async function doTemplate() {
    setBusy(true)
    try {
      const blob = await api.downloadTemplate('debtors')
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a'); a.href=url; a.download='dl01_mast_template.xlsx'; a.click()
    } catch { setToast({ok:false, msg:'Template download failed'}) }
    finally { setBusy(false) }
  }

  async function doImport() {
    if (!file) { setToast({ok:false, msg:'Please select a file first'}); return }
    setBusy(true); setToast(null)
    try {
      const data = await api.importModule('debtors', file)
      setResults(data); setToast({ok:true, msg:`Imported: ${data.imported} rows, ${data.errors} errors`})
    } catch { setToast({ok:false, msg:'Import failed'}) }
    finally { setBusy(false) }
  }

  return (
    <div className={s.page}>
      {toast && <div className={`${s.toast} ${toast.ok?s.toastOk:s.toastErr}`}>
        {toast.msg}<button onClick={()=>setToast(null)}>×</button></div>}

      {/* Tabs */}
      <div className={s.tabs}>
        <button className={`${s.tab} ${tab==='export'?s.tabActive:''}`} onClick={()=>setTab('export')}>Export</button>
        <button className={`${s.tab} ${tab==='import'?s.tabActive:''}`} onClick={()=>setTab('import')}>Import</button>
      </div>

      {tab === 'export' && (
        <>
          {/* Account range */}
          <div className={s.card}>
            <div className={s.cardTitle}>Account range</div>
            <div className={s.row2}>
              <div className={s.field}>
                <label>Start account</label>
                <LookupField value={f.startAcct} onChange={v=>set('startAcct',v)} module="debtors" placeholder="Start"/>
              </div>
              <div className={s.field}>
                <label>End account</label>
                <LookupField value={f.endAcct} onChange={v=>set('endAcct',v)} module="debtors" placeholder="End"/>
              </div>
            </div>
          </div>

          {/* Filters */}
          <div className={s.card}>
            <div className={s.cardTitle}>Filters</div>
            <div className={s.stack}>
              <div className={s.field}>
                <label>Account type</label>
                <select value={f.masterAcct} onChange={e=>set('masterAcct',e.target.value)}>
                  <option value="A">All accounts</option>
                  <option value="E">Exclude master accounts</option>
                  <option value="M">Master accounts only</option>
                  <option value="S">Standalone accounts only</option>
                </select>
              </div>
              <div className={s.field}>
                <label>Delivery account</label>
                <select value={f.delAcct} onChange={e=>set('delAcct',e.target.value)}>
                  <option value="A">All</option>
                  <option value="D">Delivery accounts only</option>
                  <option value="E">Exclude delivery accounts</option>
                </select>
              </div>
              <div className={s.field}>
                <label>Credit status</label>
                <select value={f.crStatus} onChange={e=>set('crStatus',e.target.value)}>
                  <option value="ALL">All statuses</option>
                  <option value="GOOD">Good</option>
                  <option value="HOLD">On hold</option>
                  <option value="COD">COD</option>
                </select>
              </div>
              <div className={s.field}>
                <label>Record status</label>
                <select value={f.status} onChange={e=>set('status',e.target.value)}>
                  <option value="ALL">All</option>
                  <option value="A">Active</option>
                  <option value="I">Inactive</option>
                </select>
              </div>
              <div className={s.field}>
                <label>Balance</label>
                <select value={f.balance} onChange={e=>set('balance',e.target.value)}>
                  <option value="ALL">All</option>
                  <option value="B">Non-zero balance</option>
                  <option value="Z">Zero balance</option>
                </select>
              </div>
              <div className={s.field}>
                <label>Currency tracking</label>
                <select value={f.foreignTracked} onChange={e=>set('foreignTracked',e.target.value)}>
                  <option value="ALL">All</option>
                  <option value="F">Foreign currency only</option>
                  <option value="E">Local currency only</option>
                </select>
              </div>
            </div>
          </div>

          {/* Actions */}
          <div className={s.actions}>
            <button className={s.btnPrimary} onClick={doExport} disabled={busy}>
              {busy ? 'Exporting…' : '↓ Export with filters'}
            </button>
            <button className={s.btnOutline} onClick={doTemplate} disabled={busy}>
              ⊞ Download template
            </button>
          </div>
        </>
      )}

      {tab === 'import' && (
        <>
          <div className={s.card}>
            <div className={s.cardTitle}>Import file</div>
            <div
              className={`${s.dropZone} ${drag?s.dropZoneActive:''} ${file?s.dropZoneHasFile:''}`}
              onDragOver={e=>{e.preventDefault();setDrag(true)}}
              onDragLeave={()=>setDrag(false)}
              onDrop={e=>{e.preventDefault();setDrag(false);setFile(e.dataTransfer.files[0])}}
              onClick={()=>document.getElementById('dl01file').click()}
            >
              <input id="dl01file" type="file" accept=".xlsx,.xls,.csv"
                style={{display:'none'}} onChange={e=>setFile(e.target.files[0])}/>
              {file
                ? <><div className={s.dropIcon}>✓</div><div className={s.dropText}>{file.name}</div></>
                : <><div className={s.dropIcon}>↑</div>
                    <div className={s.dropText}>Tap to select file</div>
                    <div className={s.dropHint}>or drag and drop · .xlsx .xls .csv</div></>
              }
            </div>
          </div>
          <div className={s.actions}>
            <button className={s.btnPrimary} onClick={doImport} disabled={busy||!file}>
              {busy ? 'Importing…' : '↑ Import file'}
            </button>
            {file && <button className={s.btnOutline} onClick={()=>setFile(null)}>✕ Clear</button>}
          </div>
          {results && (
            <div className={s.card}>
              <div className={s.cardTitle}>Results — {results.imported} imported, {results.errors} errors</div>
              <div className={s.resultList}>
                {results.results?.slice(0,50).map((r,i)=>(
                  <div key={i} className={`${s.resultRow} ${r.status==='OK'?s.resultOk:s.resultErr}`}>
                    <span>Row {r.rowNumber}</span>
                    <span>{r.keyField}</span>
                    <span className={s.resultBadge}>{r.status}</span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  )
}
