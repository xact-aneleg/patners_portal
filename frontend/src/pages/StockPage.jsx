import React, { useState } from 'react'
import api from '../api/bulkApi.js'
import LookupField from '../components/LookupField.jsx'
import s from './MobilePage.module.css'

export default function StockPage() {
  const [tab,setTab]=useState('export')
  const [busy,setBusy]=useState(false)
  const [toast,setToast]=useState(null)
  const [results,setResults]=useState(null)
  const [file,setFile]=useState(null)
  const [f,setF]=useState({startStkCode:'!',endStkCode:'~',masterAcct:'A',stkSelection:'C',startStkGrp:'',endStkGrp:'~~~',status:'ALL',webEnabled:'ALL',retailEnabled:'ALL',tradeInItems:'ALL',importItems:'ALL',keepBalance:'ALL'})
  const set=(k,v)=>setF(p=>({...p,[k]:v}))

  async function doExport(){setBusy(true);try{const blob=await api.exportModule('stock',f);const url=URL.createObjectURL(blob);const a=document.createElement('a');a.href=url;a.download='st01_mast.xlsx';a.click();setToast({ok:true,msg:'Exported successfully'})}catch{setToast({ok:false,msg:'Export failed'})}finally{setBusy(false)}}
  async function doTemplate(){setBusy(true);try{const blob=await api.downloadTemplate('stock');const url=URL.createObjectURL(blob);const a=document.createElement('a');a.href=url;a.download='st01_mast_template.xlsx';a.click()}catch{setToast({ok:false,msg:'Failed'})}finally{setBusy(false)}}
  async function doImport(){if(!file)return;setBusy(true);try{const data=await api.importModule('stock',file);setResults(data);setToast({ok:true,msg:`${data.imported} imported, ${data.errors} errors`})}catch{setToast({ok:false,msg:'Import failed'})}finally{setBusy(false)}}

  return (
    <div className={s.page}>
      {toast&&<div className={`${s.toast} ${toast.ok?s.toastOk:s.toastErr}`}>{toast.msg}<button onClick={()=>setToast(null)}>×</button></div>}
      <div className={s.tabs}>
        <button className={`${s.tab} ${tab==='export'?s.tabActive:''}`} onClick={()=>setTab('export')}>Export</button>
        <button className={`${s.tab} ${tab==='import'?s.tabActive:''}`} onClick={()=>setTab('import')}>Import</button>
      </div>
      {tab==='export'&&<>
        <div className={s.card}>
          <div className={s.cardTitle}>Stock code range</div>
          <div className={s.row2}>
            <div className={s.field}><label>Start code</label><LookupField value={f.startStkCode} onChange={v=>set('startStkCode',v)} module="stock" placeholder="Start"/></div>
            <div className={s.field}><label>End code</label><LookupField value={f.endStkCode} onChange={v=>set('endStkCode',v)} module="stock" placeholder="End"/></div>
          </div>
        </div>
        <div className={s.card}>
          <div className={s.cardTitle}>Filters</div>
          <div className={s.stack}>
            <div className={s.field}><label>Status</label><select value={f.status} onChange={e=>set('status',e.target.value)}><option value="ALL">All</option><option value="A">Active</option><option value="I">Inactive</option></select></div>
            <div className={s.field}><label>Web enabled</label><select value={f.webEnabled} onChange={e=>set('webEnabled',e.target.value)}><option value="ALL">All</option><option value="W">Web enabled only</option><option value="E">Exclude web</option></select></div>
            <div className={s.field}><label>Keep balance</label><select value={f.keepBalance} onChange={e=>set('keepBalance',e.target.value)}><option value="ALL">All</option><option value="K">Keep balance only</option><option value="E">No balance tracking</option></select></div>
          </div>
        </div>
        <div className={s.actions}>
          <button className={s.btnPrimary} onClick={doExport} disabled={busy}>{busy?'Exporting…':'↓ Export with filters'}</button>
          <button className={s.btnOutline} onClick={doTemplate} disabled={busy}>⊞ Download template</button>
        </div>
      </>}
      {tab==='import'&&<>
        <div className={s.card}>
          <div className={s.cardTitle}>Import file</div>
          <div className={`${s.dropZone} ${file?s.dropZoneHasFile:''}`} onClick={()=>document.getElementById('st01file').click()}>
            <input id="st01file" type="file" accept=".xlsx,.xls,.csv" style={{display:'none'}} onChange={e=>setFile(e.target.files[0])}/>
            {file?<><div className={s.dropIcon}>✓</div><div className={s.dropText}>{file.name}</div></>:<><div className={s.dropIcon}>↑</div><div className={s.dropText}>Tap to select file</div><div className={s.dropHint}>.xlsx .xls .csv</div></>}
          </div>
        </div>
        <div className={s.actions}>
          <button className={s.btnPrimary} onClick={doImport} disabled={busy||!file}>{busy?'Importing…':'↑ Import file'}</button>
          {file&&<button className={s.btnOutline} onClick={()=>setFile(null)}>✕ Clear</button>}
        </div>
      </>}
    </div>
  )
}
