import React, { useState } from 'react'
import api from '../api/bulkApi.js'
import LookupField from '../components/LookupField.jsx'
import s from './MobilePage.module.css'

function SimplePage({module, title, startKey, endKey, downloadName, filters}) {
  const [tab,setTab]=useState('export')
  const [busy,setBusy]=useState(false)
  const [toast,setToast]=useState(null)
  const [file,setFile]=useState(null)
  const [f,setF]=useState({[startKey]:'!',[endKey]:'~',...(filters||{})})
  const set=(k,v)=>setF(p=>({...p,[k]:v}))

  async function doExport(){setBusy(true);try{const blob=await api.exportModule(module,f);const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=downloadName+'.xlsx';a.click();setToast({ok:true,msg:'Exported'})}catch{setToast({ok:false,msg:'Export failed'})}finally{setBusy(false)}}
  async function doTemplate(){setBusy(true);try{const blob=await api.downloadTemplate(module);const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=downloadName+'_template.xlsx';a.click()}catch{}finally{setBusy(false)}}
  async function doImport(){if(!file)return;setBusy(true);try{const data=await api.importModule(module,file);setToast({ok:true,msg:`${data.imported} imported, ${data.errors} errors`})}catch{setToast({ok:false,msg:'Import failed'})}finally{setBusy(false)}}

  return (
    <div className={s.page}>
      {toast&&<div className={`${s.toast} ${toast.ok?s.toastOk:s.toastErr}`}>{toast.msg}<button onClick={()=>setToast(null)}>×</button></div>}
      <div className={s.tabs}>
        <button className={`${s.tab} ${tab==='export'?s.tabActive:''}`} onClick={()=>setTab('export')}>Export</button>
        <button className={`${s.tab} ${tab==='import'?s.tabActive:''}`} onClick={()=>setTab('import')}>Import</button>
      </div>
      {tab==='export'&&<>
        <div className={s.card}>
          <div className={s.cardTitle}>Account range</div>
          <div className={s.row2}>
            <div className={s.field}><label>Start</label><LookupField value={f[startKey]} onChange={v=>set(startKey,v)} module={module} placeholder="Start"/></div>
            <div className={s.field}><label>End</label><LookupField value={f[endKey]} onChange={v=>set(endKey,v)} module={module} placeholder="End"/></div>
          </div>
        </div>
        <div className={s.card}>
          <div className={s.cardTitle}>Filters</div>
          <div className={s.stack}>
            <div className={s.field}><label>Status</label><select value={f.status||'ALL'} onChange={e=>set('status',e.target.value)}><option value="ALL">All</option><option value="A">Active</option><option value="I">Inactive</option></select></div>
            {module==='creditors'&&<>
              <div className={s.field}><label>Inter-company</label><select value={f.interCo||'ALL'} onChange={e=>set('interCo',e.target.value)}><option value="ALL">All</option><option value="Y">Inter-company only</option><option value="N">Exclude inter-co</option></select></div>
              <div className={s.field}><label>Import accounts</label><select value={f.importAccts||'ALL'} onChange={e=>set('importAccts',e.target.value)}><option value="ALL">All</option><option value="Y">Import accounts only</option><option value="N">Exclude import</option></select></div>
            </>}
            {module==='gl'&&<>
              <div className={s.field}><label>Account type</label><select value={f.acctType||'A'} onChange={e=>set('acctType',e.target.value)}><option value="A">All</option><option value="B">Balance sheet</option><option value="P">P&amp;L</option></select></div>
              <div className={s.field}><label>Post / sub-total</label><select value={f.postSubTot||'A'} onChange={e=>set('postSubTot',e.target.value)}><option value="A">All</option><option value="P">Posting accounts</option><option value="S">Sub-totals</option></select></div>
            </>}
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
          <div className={`${s.dropZone} ${file?s.dropZoneHasFile:''}`} onClick={()=>document.getElementById(module+'file').click()}>
            <input id={module+'file'} type="file" accept=".xlsx,.xls,.csv" style={{display:'none'}} onChange={e=>setFile(e.target.files[0])}/>
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

export function CreditorsPage() {
  return <SimplePage module="creditors" title="Creditors" startKey="startAcct" endKey="endAcct" downloadName="cl01_mast" filters={{status:'ALL',interCo:'ALL',importAccts:'ALL',masterAccount:'A'}}/>
}
export function GLPage() {
  return <SimplePage module="gl" title="General Ledger" startKey="startCode" endKey="endCode" downloadName="gl01_mast" filters={{status:'ALL',acctType:'A',postSubTot:'A',budgetBasedOn:'ALL'}}/>
}
