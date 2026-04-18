import React, { useState } from 'react'
import { createRegistration, updateRegistration, submitRegistration } from '../api/portalApi.js'
import s from './Dashboard.module.css'

const STEPS = ['Package', 'Company details', 'Periods', 'Locations', 'Users']
const MONTHS = ['January','February','March','April','May','June','July','August','September','October','November','December']

const BLANK = {
  packageType:'LITE', numUsers:5, standalone:true, masterCompany:'', syncModules:'',
  companyName:'', masterOrSlave:'MASTER',
  postalAddr1:'', postalAddr2:'', postalAddr3:'', postalAddr4:'',
  physicalAddr1:'', physicalAddr2:'', physicalAddr3:'', physicalAddr4:'',
  telephone:'', fax:'', companyEmail:'', companyDomain:'', regNumber:'', vatNumber:'',
  yearEndMonth:3, vatRate:15, bankName:'', bankBranch:'', bankBranchCode:'', bankAccount:'',
  multiCurrency:false, localCurrency:'South African Rand', currencyCode:'ZAR',
  periodGl:1, periodCb:1, periodDl:1, periodSa:1, periodCl:1, periodPu:1, systemYearEnd:2024,
  locations:[{ loc:'001', whs:'001', locName:'Main', region:'', stockLoc:true, physicalAddr1:'', physicalAddr2:'', physicalAddr3:'', physicalAddr4:'' }],
  users:[{ username:'', fullName:'', email:'', defaultLoc:'001', accessGrp:'ADMIN' }],
}

export default function RegistrationForm({ onBack, onDone }) {
  const [step, setStep]   = useState(0)
  const [data, setData]   = useState({ ...BLANK })
  const [regId, setRegId] = useState(null)
  const [busy, setBusy]   = useState(false)
  const [err,  setErr]    = useState(null)

  const set = (k, v) => setData(d => ({ ...d, [k]: v }))
  const setLoc = (i, k, v) => setData(d => {
    const locs = [...d.locations]; locs[i] = { ...locs[i], [k]: v }; return { ...d, locations: locs }
  })
  const setUsr = (i, k, v) => setData(d => {
    const users = [...d.users]; users[i] = { ...users[i], [k]: v }; return { ...d, users }
  })
  const addLoc = () => setData(d => ({ ...d, locations:[...d.locations,{loc:'',whs:'',locName:'',region:'',stockLoc:false,physicalAddr1:'',physicalAddr2:'',physicalAddr3:'',physicalAddr4:''}] }))
  const addUsr = () => setData(d => ({ ...d, users:[...d.users,{username:'',fullName:'',email:'',defaultLoc:'',accessGrp:''}] }))
  const delLoc = i => setData(d => ({ ...d, locations:d.locations.filter((_,j)=>j!==i) }))
  const delUsr = i => setData(d => ({ ...d, users:d.users.filter((_,j)=>j!==i) }))

  async function saveAndNext() {
    setBusy(true); setErr(null)
    try {
      let reg
      if (!regId) reg = await createRegistration(data)
      else        reg = await updateRegistration(regId, data)
      setRegId(reg.id)
      if (step < STEPS.length - 1) setStep(step + 1)
      else await finish(reg.id)
    } catch(e) { setErr(e.response?.data?.message || 'Save failed') }
    finally { setBusy(false) }
  }

  async function finish(id) {
    await submitRegistration(id)
    onDone()
  }

  return (
    <div>
      {/* Step indicator */}
      <div className={s.steps}>
        {STEPS.map((label, i) => (
          <React.Fragment key={i}>
            <div className={s.stStep}>
              <div className={s.stNum} style={{
                background: i < step ? '#39B54A' : i === step ? '#3D5166' : '#EEF1F4',
                color: i <= step ? '#fff' : '#B0BFCC',
                border: i > step ? '1px solid #C8D4DC' : 'none',
              }}>{i+1}</div>
              <span style={{ fontSize:'11px', fontWeight:i===step?700:500, color: i===step?'#2E3D4D':i<step?'#39B54A':'#B0BFCC' }}>{label}</span>
            </div>
            {i < STEPS.length-1 && <span className={s.stArr}>›</span>}
          </React.Fragment>
        ))}
      </div>

      {err && <div className={s.declineReason}>{err}</div>}

      {/* Step 0 — Package */}
      {step === 0 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Package selection</span></div>
          <div className={s.cb}>
            <div className={s.grid2} style={{marginBottom:14}}>
              {['LITE','PRO'].map(pkg => (
                <div key={pkg}
                  onClick={() => set('packageType', pkg)}
                  style={{border:`2px solid ${data.packageType===pkg?'#39B54A':'#C8D4DC'}`,
                    background:data.packageType===pkg?'#EAF3DE':'#fff',
                    borderRadius:6,padding:14,cursor:'pointer'}}>
                  <div style={{fontSize:14,fontWeight:700,color:pkg==='LITE'?'#27500A':'#0C447C',marginBottom:3}}>
                    Xact {pkg==='LITE'?'Lite':'Pro'}
                  </div>
                  <div style={{fontSize:11,color:'#546E7A'}}>
                    {pkg==='LITE'?'SME focused · 1-step approval (XactERP only)':'Enterprise · 2-step approval (Imply → XactERP)'}
                  </div>
                  <div style={{fontSize:10,fontWeight:700,marginTop:6,color:pkg==='LITE'?'#27500A':'#0C447C'}}>
                    {pkg==='LITE'?'✓ Approved by XactERP':'✓ Imply approval › then XactERP review'}
                  </div>
                </div>
              ))}
            </div>
            <div className={s.grid3}>
              <div className={s.f}><label>Number of users</label><input type="number" min="1" value={data.numUsers} onChange={e=>set('numUsers',+e.target.value)} /></div>
              <div className={s.f}><label>Company type</label>
                <select value={data.standalone?'yes':'no'} onChange={e=>set('standalone',e.target.value==='yes')}>
                  <option value="yes">Standalone company</option>
                  <option value="no">Linked to master company</option>
                </select>
              </div>
              {!data.standalone && <div className={s.f}><label>Master company</label><input value={data.masterCompany} onChange={e=>set('masterCompany',e.target.value)} /></div>}
            </div>
          </div>
        </div>
      )}

      {/* Step 1 — Company details */}
      {step === 1 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Company details</span></div>
          <div className={s.cb}>
            <div className={s.grid2}>
              <div className={`${s.f} ${s.fspan2}`}><label>Company name *</label><input value={data.companyName} onChange={e=>set('companyName',e.target.value)} placeholder="e.g. Zeta Manufacturing (Pty) Ltd" /></div>
              <div className={s.f}><label>Registration number *</label><input value={data.regNumber} onChange={e=>set('regNumber',e.target.value)} /></div>
              <div className={s.f}><label>VAT number</label><input value={data.vatNumber} onChange={e=>set('vatNumber',e.target.value)} /></div>
              <div className={s.f}><label>Company email *</label><input type="email" value={data.companyEmail} onChange={e=>set('companyEmail',e.target.value)} /></div>
              <div className={s.f}><label>Telephone *</label><input value={data.telephone} onChange={e=>set('telephone',e.target.value)} /></div>
              <div className={s.f}><label>Postal address line 1</label><input value={data.postalAddr1} onChange={e=>set('postalAddr1',e.target.value)} /></div>
              <div className={s.f}><label>Line 2</label><input value={data.postalAddr2} onChange={e=>set('postalAddr2',e.target.value)} /></div>
              <div className={s.f}><label>Line 3</label><input value={data.postalAddr3} onChange={e=>set('postalAddr3',e.target.value)} /></div>
              <div className={s.f}><label>Line 4 / Postal code</label><input value={data.postalAddr4} onChange={e=>set('postalAddr4',e.target.value)} /></div>
              <div className={s.f}><label>Bank name</label><input value={data.bankName} onChange={e=>set('bankName',e.target.value)} /></div>
              <div className={s.f}><label>Bank branch code</label><input value={data.bankBranchCode} onChange={e=>set('bankBranchCode',e.target.value)} /></div>
              <div className={s.f}><label>Bank account number</label><input value={data.bankAccount} onChange={e=>set('bankAccount',e.target.value)} /></div>
              <div className={s.f}><label>Year end month</label>
                <select value={data.yearEndMonth} onChange={e=>set('yearEndMonth',+e.target.value)}>
                  {MONTHS.map((m,i)=><option key={i+1} value={i+1}>{m}</option>)}
                </select>
              </div>
              <div className={s.f}><label>Currency code</label><input value={data.currencyCode} onChange={e=>set('currencyCode',e.target.value)} /></div>
              <div className={s.f}><label>VAT rate (%)</label><input type="number" value={data.vatRate} onChange={e=>set('vatRate',+e.target.value)} /></div>
            </div>
          </div>
        </div>
      )}

      {/* Step 2 — Periods */}
      {step === 2 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Periods and year ends</span></div>
          <div className={s.cb}>
            <div style={{marginBottom:10,fontSize:12,color:'#546E7A'}}>Enter the current period number for each module at time of registration.</div>
            <div className={s.grid3}>
              {[['GL','periodGl'],['CB','periodCb'],['DL','periodDl'],['SA','periodSa'],['CL','periodCl'],['PU','periodPu']].map(([lbl,key])=>(
                <div key={key} className={s.f}><label>{lbl} period</label><input type="number" min="1" max="12" value={data[key]||''} onChange={e=>set(key,+e.target.value)} /></div>
              ))}
              <div className={s.f}><label>System year end</label><input type="number" value={data.systemYearEnd||''} onChange={e=>set('systemYearEnd',+e.target.value)} /></div>
            </div>
          </div>
        </div>
      )}

      {/* Step 3 — Locations */}
      {step === 3 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Location setup</span>
            <div className={s.ca}><button className={s.btnSm} onClick={addLoc}>+ Add location</button></div>
          </div>
          <div className={s.cb}>
            {data.locations.map((loc, i) => (
              <div key={i} style={{border:'1px solid #C8D4DC',borderRadius:6,padding:12,marginBottom:10}}>
                <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:8}}>
                  <span style={{fontSize:11,fontWeight:700,color:'#3D5166'}}>Location {i+1}</span>
                  {data.locations.length > 1 && <button className={s.btnSmR} onClick={()=>delLoc(i)}>Remove</button>}
                </div>
                <div className={s.grid3}>
                  <div className={s.f}><label>Loc code</label><input value={loc.loc} onChange={e=>setLoc(i,'loc',e.target.value)} placeholder="001" /></div>
                  <div className={s.f}><label>Whs code</label><input value={loc.whs} onChange={e=>setLoc(i,'whs',e.target.value)} placeholder="001" /></div>
                  <div className={s.f}><label>Location name</label><input value={loc.locName} onChange={e=>setLoc(i,'locName',e.target.value)} /></div>
                  <div className={s.f}><label>Region</label><input value={loc.region} onChange={e=>setLoc(i,'region',e.target.value)} /></div>
                  <div className={s.f}><label>Stock location?</label>
                    <select value={loc.stockLoc?'Y':'N'} onChange={e=>setLoc(i,'stockLoc',e.target.value==='Y')}>
                      <option value="Y">Yes</option><option value="N">No</option>
                    </select>
                  </div>
                  <div className={s.f}><label>Physical address</label><input value={loc.physicalAddr1} onChange={e=>setLoc(i,'physicalAddr1',e.target.value)} /></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Step 4 — Users */}
      {step === 4 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Base users</span>
            <div className={s.ca}><button className={s.btnSm} onClick={addUsr}>+ Add user</button></div>
          </div>
          <div className={s.cb}>
            {data.users.map((u, i) => (
              <div key={i} style={{border:'1px solid #C8D4DC',borderRadius:6,padding:12,marginBottom:10}}>
                <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:8}}>
                  <span style={{fontSize:11,fontWeight:700,color:'#3D5166'}}>User {i+1}</span>
                  {data.users.length > 1 && <button className={s.btnSmR} onClick={()=>delUsr(i)}>Remove</button>}
                </div>
                <div className={s.grid3}>
                  <div className={s.f}><label>Username *</label><input value={u.username} onChange={e=>setUsr(i,'username',e.target.value)} /></div>
                  <div className={s.f}><label>Full name</label><input value={u.fullName} onChange={e=>setUsr(i,'fullName',e.target.value)} /></div>
                  <div className={s.f}><label>Email</label><input type="email" value={u.email} onChange={e=>setUsr(i,'email',e.target.value)} /></div>
                  <div className={s.f}><label>Default location</label><input value={u.defaultLoc} onChange={e=>setUsr(i,'defaultLoc',e.target.value)} /></div>
                  <div className={s.f}><label>Access group</label><input value={u.accessGrp} onChange={e=>setUsr(i,'accessGrp',e.target.value)} /></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      <div style={{display:'flex',gap:10,justifyContent:'space-between',marginTop:4}}>
        <button className={s.btnSm} onClick={step===0?onBack:()=>setStep(step-1)}>
          {step===0?'Cancel':'← Back'}
        </button>
        <div style={{display:'flex',gap:8}}>
          <button className={s.btnSm} onClick={async()=>{
            setBusy(true)
            try {
              if(!regId) { const r=await createRegistration(data); setRegId(r.id) }
              else await updateRegistration(regId,data)
            } finally { setBusy(false) }
          }}>Save draft</button>
          <button className={s.btnG} onClick={saveAndNext} disabled={busy}>
            {busy?'Saving…':step===STEPS.length-1?'Submit for approval':'Next →'}
          </button>
        </div>
      </div>
    </div>
  )
}
