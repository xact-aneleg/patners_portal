import React, { useState, useEffect } from 'react'
import api from '../api/bulkApi.js'
import LookupField from '../components/LookupField.jsx'
import s from './MobilePage.module.css'

export default function StockPage() {
  const [tab,setTab]=useState('export')
  const [busy,setBusy]=useState(false)
  const [toast,setToast]=useState(null)
  const [results,setResults]=useState(null)
  const [file,setFile]=useState(null)
  const [f,setF]=useState({
    startStkCode:'',endStkCode:'',
    masterAcct:'A',
    stkSelection:'C',
    startStkGrp:'',endStkGrp:'~~~',
    startSubGrp:'',endSubGrp:'~~~',
    startSection:'',endSection:'~~~',
    startDiv:'',endDiv:'~~~',
    status:'ALL',
    webEnabled:'ALL',retailEnabled:'ALL',tradeInItems:'ALL',importItems:'ALL',keepBalance:'ALL'
  })
  const set=(k,v)=>setF(p=>({...p,[k]:v}))

  useEffect(() => {
    api.getCodeRange('stock')
      .then(r => setF(p => ({...p, startStkCode: r.first, endStkCode: r.last})))
      .catch(() => setF(p => ({...p, startStkCode: '!', endStkCode: '~'})))
  }, [])

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
          <div className={s.cardTitle}>Selection mode</div>
          <div className={s.stack}>
            <div className={s.field}><label>Select by</label>
              <select value={f.stkSelection} onChange={e=>set('stkSelection',e.target.value)}>
                <option value="C">Code range</option>
                <option value="G">Group range</option>
                <option value="SG">Sub-group range</option>
                <option value="S">Section range</option>
                <option value="D">Division range</option>
              </select>
            </div>
            {f.stkSelection==='G'&&<div className={s.row2}>
              <div className={s.field}><label>Start group</label><LookupField value={f.startStkGrp} onChange={v=>set('startStkGrp',v)} module="stockgrp" placeholder="Start"/></div>
              <div className={s.field}><label>End group</label><LookupField value={f.endStkGrp} onChange={v=>set('endStkGrp',v)} module="stockgrp" placeholder="End"/></div>
            </div>}
            {f.stkSelection==='SG'&&<div className={s.row2}>
              <div className={s.field}><label>Start sub-group</label><input value={f.startSubGrp} onChange={e=>set('startSubGrp',e.target.value)} placeholder="Start"/></div>
              <div className={s.field}><label>End sub-group</label><input value={f.endSubGrp} onChange={e=>set('endSubGrp',e.target.value)} placeholder="End"/></div>
            </div>}
            {f.stkSelection==='S'&&<div className={s.row2}>
              <div className={s.field}><label>Start section</label><input value={f.startSection} onChange={e=>set('startSection',e.target.value)} placeholder="Start"/></div>
              <div className={s.field}><label>End section</label><input value={f.endSection} onChange={e=>set('endSection',e.target.value)} placeholder="End"/></div>
            </div>}
            {f.stkSelection==='D'&&<div className={s.row2}>
              <div className={s.field}><label>Start division</label><input value={f.startDiv} onChange={e=>set('startDiv',e.target.value)} placeholder="Start"/></div>
              <div className={s.field}><label>End division</label><input value={f.endDiv} onChange={e=>set('endDiv',e.target.value)} placeholder="End"/></div>
            </div>}
          </div>
        </div>
        <div className={s.card}>
          <div className={s.cardTitle}>Filters</div>
          <div className={s.stack}>
            <div className={s.field}><label>Master account</label>
              <select value={f.masterAcct} onChange={e=>set('masterAcct',e.target.value)}>
                <option value="A">All accounts</option>
                <option value="E">Exclude masters</option>
                <option value="M">Masters only</option>
                <option value="S">Standalone only</option>
              </select>
            </div>
            <div className={s.field}><label>Status</label><select value={f.status} onChange={e=>set('status',e.target.value)}><option value="ALL">All</option><option value="A">Active</option><option value="I">Inactive</option></select></div>
            <div className={s.field}><label>Web enabled</label><select value={f.webEnabled} onChange={e=>set('webEnabled',e.target.value)}><option value="ALL">All</option><option value="W">Web enabled only</option><option value="E">Exclude web</option></select></div>
            <div className={s.field}><label>Retail enabled</label><select value={f.retailEnabled} onChange={e=>set('retailEnabled',e.target.value)}><option value="ALL">All</option><option value="R">Retail enabled only</option><option value="E">Exclude retail</option></select></div>
            <div className={s.field}><label>Trade-in items</label><select value={f.tradeInItems} onChange={e=>set('tradeInItems',e.target.value)}><option value="ALL">All</option><option value="T">Trade-in only</option><option value="E">Exclude trade-in</option></select></div>
            <div className={s.field}><label>Import items</label><select value={f.importItems} onChange={e=>set('importItems',e.target.value)}><option value="ALL">All</option><option value="IM">Import items only</option><option value="E">Exclude import</option></select></div>
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
      {results&&<div className={s.card}>
        <div className={s.cardTitle}>Import results — {results.imported} ok / {results.errors} errors</div>
        {results.results.filter(r=>r.status==='ERROR').map((r,i)=>(
          <div key={i} className={s.errRow}><span className={s.errBadge}>Row {r.rowNumber}</span><span>{r.fieldName}: {r.exception}</span></div>
        ))}
      </div>}
    </div>
  )
}
