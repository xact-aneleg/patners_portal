import React, { useState, useEffect } from 'react'
import { Sparkles, X, Wand2 } from 'lucide-react'
import api from '../api/bulkApi.js'
import LookupField from '../components/LookupField.jsx'
import s from './MobilePage.module.css'
import ai from './AiPanel.module.css'

export default function DebtorsPage() {
  const [tab,     setTab]     = useState('export')
  const [busy,    setBusy]    = useState(false)
  const [toast,   setToast]   = useState(null)
  const [results, setResults] = useState(null)
  const [file,    setFile]    = useState(null)
  const [drag,    setDrag]    = useState(false)

  const [f, setF] = useState({
    startAcct:'', endAcct:'',
    masterAcct:'A', delAcct:'A',
    status:'ALL', crStatus:'ALL', invType:'ALL',
    balance:'ALL', foreignTracked:'ALL',
    filterCat:false, startCat:'', endCat:'~~~',
    filterController:false, startController:'', endController:'~~~',
    filterClass:false, startClass:'', endClass:'~~~',
    filterRep:false, repType:'R', startRep:'', endRep:'~~~',
  })
  const set = (k,v) => setF(p => ({...p,[k]:v}))

  useEffect(() => {
    api.getCodeRange('debtors')
      .then(r => setF(p => ({...p, startAcct: r.first, endAcct: r.last})))
      .catch(() => setF(p => ({...p, startAcct: '!', endAcct: '~'})))
  }, [])

  // AI filter assistant state
  const [aiOpen,   setAiOpen]   = useState(false)
  const [aiDesc,   setAiDesc]   = useState('')
  const [aiLoading,setAiLoading]= useState(false)
  const [aiResult, setAiResult] = useState(null)
  const [aiErr,    setAiErr]    = useState(null)

  async function askAi() {
    if (!aiDesc.trim()) return
    setAiLoading(true); setAiErr(null); setAiResult(null)
    try {
      const data = await api.aiFilterSuggest('debtors', aiDesc)
      setAiResult(data)
    } catch (e) {
      setAiErr(e.response?.data?.message || e.response?.data || e.message || 'AI request failed')
    } finally { setAiLoading(false) }
  }

  function applyAiFilters(r) {
    if (r?.filters) setF(prev => ({ ...prev, ...r.filters }))
    setAiOpen(false)
  }

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

      {/* AI overlay */}
      {aiOpen && (
        <div className={ai.overlay} onClick={() => setAiOpen(false)}>
          <div className={ai.panel} onClick={e => e.stopPropagation()}>
            <div className={ai.header}>
              <span className={ai.title}><Sparkles size={16}/> AI Filter Assistant</span>
              <button className={ai.close} onClick={() => setAiOpen(false)}><X size={16}/></button>
            </div>
            <div className={ai.body}>
              <p className={ai.hint}>Describe what you want to export in plain language.</p>
              <textarea className={ai.textarea} rows={3}
                placeholder='e.g. "All debtors on hold with positive balance"'
                value={aiDesc} onChange={e => setAiDesc(e.target.value)}/>
              <button className={ai.submit} onClick={askAi} disabled={aiLoading || !aiDesc.trim()}>
                {aiLoading ? 'Thinking…' : <><Wand2 size={14}/> Suggest filters</>}
              </button>
              {aiErr && <div className={ai.error}>{aiErr}</div>}
              {aiResult && (
                <div className={ai.result}>
                  {aiResult.reasoning && <p className={ai.reasoning}>{aiResult.reasoning}</p>}
                  {Object.entries(aiResult.filters || {}).map(([k,v]) => (
                    <div key={k} className={ai.row}>
                      <span className={ai.key}>{k}</span>
                      <span className={ai.val}>{v}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
            {aiResult && (
              <div className={ai.footer}>
                <button className={ai.decline} onClick={() => { setAiResult(null); setAiDesc('') }}>Discard</button>
                <button className={ai.apply} onClick={() => applyAiFilters(aiResult)}>
                  <Wand2 size={14}/> Apply filters
                </button>
              </div>
            )}
          </div>
        </div>
      )}

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
            <div style={{display:'flex',alignItems:'center',justifyContent:'space-between',marginBottom:'14px'}}>
              <span className={s.cardTitle} style={{margin:0,padding:0,border:0}}>Filters</span>
              <button
                onClick={() => setAiOpen(true)}
                style={{
                  display:'flex',alignItems:'center',gap:'5px',
                  height:'28px',padding:'0 10px',
                  background:'var(--color-primary)',color:'#fff',
                  border:'none',borderRadius:'6px',
                  fontSize:'12px',fontWeight:'700',cursor:'pointer',fontFamily:'inherit'
                }}>
                <Sparkles size={13}/> AI filters
              </button>
            </div>
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
              <div className={s.field}>
                <label>Invoice type</label>
                <select value={f.invType} onChange={e=>set('invType',e.target.value)}>
                  <option value="ALL">All</option>
                  <option value="I">Invoice</option>
                  <option value="C">Cash</option>
                  <option value="T">Tax</option>
                  <option value="O">Other</option>
                </select>
              </div>
              {/* Category range */}
              <div className={s.field}>
                <label style={{display:'flex',alignItems:'center',gap:'6px',cursor:'pointer'}}>
                  <input type="checkbox" checked={f.filterCat} onChange={e=>set('filterCat',e.target.checked)}/>
                  Filter by category
                </label>
              </div>
              {f.filterCat&&<div className={s.row2}>
                <div className={s.field}><label>Start category</label><input value={f.startCat} onChange={e=>set('startCat',e.target.value)} placeholder="Start"/></div>
                <div className={s.field}><label>End category</label><input value={f.endCat} onChange={e=>set('endCat',e.target.value)} placeholder="End"/></div>
              </div>}
              {/* Controller range */}
              <div className={s.field}>
                <label style={{display:'flex',alignItems:'center',gap:'6px',cursor:'pointer'}}>
                  <input type="checkbox" checked={f.filterController} onChange={e=>set('filterController',e.target.checked)}/>
                  Filter by controller
                </label>
              </div>
              {f.filterController&&<div className={s.row2}>
                <div className={s.field}><label>Start controller</label><input value={f.startController} onChange={e=>set('startController',e.target.value)} placeholder="Start"/></div>
                <div className={s.field}><label>End controller</label><input value={f.endController} onChange={e=>set('endController',e.target.value)} placeholder="End"/></div>
              </div>}
              {/* Class range */}
              <div className={s.field}>
                <label style={{display:'flex',alignItems:'center',gap:'6px',cursor:'pointer'}}>
                  <input type="checkbox" checked={f.filterClass} onChange={e=>set('filterClass',e.target.checked)}/>
                  Filter by class
                </label>
              </div>
              {f.filterClass&&<div className={s.row2}>
                <div className={s.field}><label>Start class</label><input value={f.startClass} onChange={e=>set('startClass',e.target.value)} placeholder="Start"/></div>
                <div className={s.field}><label>End class</label><input value={f.endClass} onChange={e=>set('endClass',e.target.value)} placeholder="End"/></div>
              </div>}
              {/* Rep range */}
              <div className={s.field}>
                <label style={{display:'flex',alignItems:'center',gap:'6px',cursor:'pointer'}}>
                  <input type="checkbox" checked={f.filterRep} onChange={e=>set('filterRep',e.target.checked)}/>
                  Filter by rep
                </label>
              </div>
              {f.filterRep&&<>
                <div className={s.field}><label>Rep type</label>
                  <select value={f.repType} onChange={e=>set('repType',e.target.value)}>
                    <option value="R">Sales rep</option>
                    <option value="M">Market rep</option>
                  </select>
                </div>
                <div className={s.row2}>
                  <div className={s.field}><label>Start rep</label><input value={f.startRep} onChange={e=>set('startRep',e.target.value)} placeholder="Start"/></div>
                  <div className={s.field}><label>End rep</label><input value={f.endRep} onChange={e=>set('endRep',e.target.value)} placeholder="End"/></div>
                </div>
              </>}
            </div>
          </div>

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
