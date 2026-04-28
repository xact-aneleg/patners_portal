import React, { useState, useEffect } from 'react'
import api from '../api/bulkApi.js'
import s from './MobilePage.module.css'

const MODULES = [
  {id:'debtors',   label:'Debtors',       table:'dl01_mast'},
  {id:'stock',     label:'Stock',          table:'st01_mast'},
  {id:'creditors', label:'Creditors',      table:'cl01_mast'},
  {id:'gl',        label:'GL accounts',    table:'gl01_mast'},
]

export default function ConversionPage() {
  const [counts,  setCounts]  = useState({})
  const [selected,setSelected]= useState('debtors')
  const [empty,   setEmpty]   = useState(false)
  const [busy,    setBusy]    = useState(false)
  const [file,    setFile]    = useState(null)
  const [toast,   setToast]   = useState(null)

  useEffect(() => {
    MODULES.forEach(m => {
      api.getCount(m.id).then(n => setCounts(c => ({...c,[m.id]:n}))).catch(()=>{})
    })
  }, [])

  async function doExport() {
    setBusy(true)
    try {
      const mod = MODULES.find(m=>m.id===selected)
      const blob = await api.conversionExport(selected)
      const a = document.createElement('a'); a.href=URL.createObjectURL(blob)
      a.download = mod.table+'_full.xlsx'; a.click()
      setToast({ok:true, msg:'Full export downloaded'})
    } catch { setToast({ok:false, msg:'Export failed'}) }
    finally { setBusy(false) }
  }

  async function doImport() {
    if (!file) { setToast({ok:false, msg:'Select a file first'}); return }
    if (empty && !confirm(`This will DELETE all rows in ${selected} before importing. Continue?`)) return
    setBusy(true)
    try {
      const data = await api.conversionImport(file, selected, empty)
      setToast({ok:true, msg:`Imported ${data.imported||'?'} rows`})
    } catch { setToast({ok:false, msg:'Import failed'}) }
    finally { setBusy(false) }
  }

  return (
    <div className={s.page}>
      {toast&&<div className={`${s.toast} ${toast.ok?s.toastOk:s.toastErr}`}>{toast.msg}<button onClick={()=>setToast(null)}>×</button></div>}

      {/* Stat cards */}
      <div className={s.statGrid}>
        {MODULES.map(m => (
          <div key={m.id}
            className={`${s.statCard} ${selected===m.id?s.statCardActive:''}`}
            onClick={()=>setSelected(m.id)}>
            <div className={s.statNum}>{counts[m.id]??'…'}</div>
            <div className={s.statLbl}>{m.label}</div>
          </div>
        ))}
      </div>

      {/* Selected module */}
      <div className={s.card}>
        <div className={s.cardTitle}>
          {MODULES.find(m=>m.id===selected)?.label} — {MODULES.find(m=>m.id===selected)?.table}
        </div>

        <div className={s.actions} style={{marginBottom:14}}>
          <button className={s.btnOutline} onClick={doExport} disabled={busy}>
            ↓ Full export ({counts[selected]??'?'} rows)
          </button>
        </div>

        <div className={s.field} style={{marginBottom:14}}>
          <label style={{display:'flex',alignItems:'center',gap:8,textTransform:'none',fontSize:13,color:'#1a2733'}}>
            <input type="checkbox" checked={empty} onChange={e=>setEmpty(e.target.checked)}
              style={{width:18,height:18,margin:0,accentColor:'#dc3545'}}/>
            Empty table before importing
          </label>
          {empty && <p style={{fontSize:12,color:'#dc3545',marginTop:4}}>⚠ All existing rows will be deleted before import</p>}
        </div>

        <div className={`${s.dropZone} ${file?s.dropZoneHasFile:''}`}
          onClick={()=>document.getElementById('convfile').click()}>
          <input id="convfile" type="file" accept=".xlsx,.xls,.csv"
            style={{display:'none'}} onChange={e=>setFile(e.target.files[0])}/>
          {file
            ?<><div className={s.dropIcon}>✓</div><div className={s.dropText}>{file.name}</div></>
            :<><div className={s.dropIcon}>↑</div><div className={s.dropText}>Tap to select import file</div><div className={s.dropHint}>.xlsx .xls .csv</div></>
          }
        </div>
      </div>

      <div className={s.actions}>
        <button className={empty?s.btnDanger:s.btnPrimary} onClick={doImport} disabled={busy||!file}>
          {busy?'Importing…':empty?'⚠ Empty & Import':'↑ Import'}
        </button>
        {file&&<button className={s.btnOutline} onClick={()=>setFile(null)}>✕ Clear</button>}
      </div>
    </div>
  )
}
