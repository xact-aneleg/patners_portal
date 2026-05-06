import React, { useState } from 'react'
import { createRegistration, updateRegistration, submitRegistration } from '../api/portalApi.js'
import s from './Portal.module.css'

const STEPS = [
  { num:1, label:'Package' },
  { num:2, label:'Company' },
  { num:3, label:'Periods' },
  { num:4, label:'Locations' },
  { num:5, label:'Users' },
]

const MONTHS = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

const emptyLoc  = () => ({ loc:'', whs:'001', locName:'', region:'', stockLoc:true, physicalAddr1:'', physicalAddr2:'', physicalAddr3:'', physicalAddr4:'' })
const emptyUser = () => ({ username:'', fullName:'', email:'', defaultLoc:'', accessGrp:'A1' })

export default function RegistrationForm({ onBack, onDone }) {
  const [step, setStep]   = useState(1)
  const [regId, setRegId] = useState(null)
  const [busy, setBusy]   = useState(false)
  const [err,  setErr]    = useState(null)

  // Step 1 — Package
  const [pkg,         setPkg]         = useState('LITE')
  const [numUsers,    setNumUsers]    = useState(5)
  const [standalone,  setStandalone]  = useState(true)

  // Step 2 — Company
  const [companyName,   setCompanyName]   = useState('')
  const [regNumber,     setRegNumber]     = useState('')
  const [vatNumber,     setVatNumber]     = useState('')
  const [companyEmail,  setCompanyEmail]  = useState('')
  const [telephone,     setTelephone]     = useState('')
  const [currencyCode,  setCurrencyCode]  = useState('ZAR')
  const [yearEndMonth,  setYearEndMonth]  = useState(2)
  const [vatRate,       setVatRate]       = useState(15)
  const [bankName,      setBankName]      = useState('')
  const [bankBranch,    setBankBranch]    = useState('')
  const [bankBranchCode,setBankBranchCode]= useState('')
  const [bankAccount,   setBankAccount]   = useState('')

  // Step 3 — Periods
  const [periodGl, setPeriodGl] = useState(1)
  const [periodCb, setPeriodCb] = useState(1)
  const [periodDl, setPeriodDl] = useState(1)
  const [periodSa, setPeriodSa] = useState(1)
  const [periodCl, setPeriodCl] = useState(1)
  const [periodPu, setPeriodPu] = useState(1)
  const [sysYearEnd, setSysYearEnd] = useState(new Date().getFullYear())

  // Step 4 — Locations
  const [locs, setLocs] = useState([emptyLoc()])

  // Step 5 — Users
  const [users, setUsers] = useState([emptyUser()])

  function buildPayload() {
    return {
      packageType:pkg, numUsers, standalone, masterOrSlave: standalone ? 'MASTER' : 'SLAVE',
      companyName, regNumber, vatNumber, companyEmail, telephone, currencyCode,
      yearEndMonth, vatRate, bankName, bankBranch, bankBranchCode, bankAccount,
      periodGl, periodCb, periodDl, periodSa, periodCl, periodPu,
      systemYearEnd: sysYearEnd,
      locations: locs, users,
    }
  }

  async function saveAndNext() {
    if (!companyName && step === 2) { setErr('Company name is required'); return }
    setBusy(true); setErr(null)
    try {
      const payload = buildPayload()
      const saved = regId
        ? await updateRegistration(regId, payload)
        : await createRegistration(payload)
      if (!regId) setRegId(saved.id)
      setStep(s => s + 1)
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to save')
    } finally { setBusy(false) }
  }

  async function handleSubmit() {
    setBusy(true); setErr(null)
    try {
      const payload = buildPayload()
      const saved = regId
        ? await updateRegistration(regId, payload)
        : await createRegistration(payload)
      const id = regId || saved.id
      await submitRegistration(id)
      onDone()
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to submit')
    } finally { setBusy(false) }
  }

  async function saveDraft() {
    setBusy(true); setErr(null)
    try {
      const payload = buildPayload()
      const saved = regId
        ? await updateRegistration(regId, payload)
        : await createRegistration(payload)
      if (!regId) setRegId(saved.id)
      setErr(null)
      onDone()
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to save draft')
    } finally { setBusy(false) }
  }

  // Loc helpers
  const setLoc  = (i, k, v) => setLocs(prev => prev.map((l, idx) => idx===i ? {...l,[k]:v} : l))
  const addLoc  = () => setLocs(prev => [...prev, emptyLoc()])
  const remLoc  = i => setLocs(prev => prev.filter((_,idx) => idx!==i))

  // User helpers
  const setUser  = (i, k, v) => setUsers(prev => prev.map((u, idx) => idx===i ? {...u,[k]:v} : u))
  const addUser  = () => setUsers(prev => [...prev, emptyUser()])
  const remUser  = i => setUsers(prev => prev.filter((_,idx) => idx!==i))

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}<button className={s.alertClose} onClick={()=>setErr(null)}>×</button></div>}

      {/* ── Step progress ── */}
      <div className={s.stepBar}>
        {STEPS.map((st, i) => {
          const done   = step > st.num
          const active = step === st.num
          return (
            <div key={st.num} className={s.stepItem}>
              {i > 0 && <span className={s.stepArrow}>›</span>}
              <div className={`${s.stepNum} ${active ? s.stepNumActive : ''} ${done ? s.stepNumDone : ''}`}>
                {done ? '✓' : st.num}
              </div>
              <span className={`${s.stepLabel} ${active ? s.stepLabelActive : ''} ${done ? s.stepLabelDone : ''}`}>
                {st.label}
              </span>
            </div>
          )
        })}
      </div>

      {/* ══ Step 1: Package ══ */}
      {step === 1 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Package selection</div>
            <div className={s.formCardSub}>Choose the right XactERP package</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.pkgGrid}>
              {[
                { id:'LITE', name:'Xact Lite', desc:'SME focused · 1-step approval (XactERP only)', check:'✓ Approved by XactERP' },
                { id:'PRO',  name:'Xact Pro',  desc:'Enterprise · 2-step approval (Imply → XactERP)', check:'✓ Imply approval › then XactERP review' },
              ].map(p => (
                <div key={p.id}
                  className={`${s.pkgCard} ${pkg===p.id ? s.pkgCardActive : ''}`}
                  onClick={() => setPkg(p.id)}>
                  <div className={s.pkgName}>{p.name}</div>
                  <div className={s.pkgDesc}>{p.desc}</div>
                  <div className={s.pkgCheck}>{p.check}</div>
                </div>
              ))}
            </div>

            <div className={s.field}>
              <label className={s.fieldLabel}>Number of users</label>
              <input className={s.fieldInput} type="number" min={1} max={500}
                value={numUsers} onChange={e=>setNumUsers(+e.target.value)}/>
            </div>

            <div className={s.field}>
              <label className={s.fieldLabel}>Company type</label>
              <select className={s.fieldSelect} value={standalone?'Y':'N'}
                onChange={e=>setStandalone(e.target.value==='Y')}>
                <option value="Y">Standalone company</option>
                <option value="N">Linked to master company</option>
              </select>
            </div>

            <div className={s.formNav}>
              <button className={s.btnBack} onClick={onBack}>Cancel</button>
              <button className={s.btnSave} onClick={saveDraft} disabled={busy}>Save draft</button>
              <button className={s.btnNext} onClick={()=>setStep(2)} disabled={busy}>Next →</button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Step 2: Company details ══ */}
      {step === 2 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Company details</div>
            <div className={s.formCardSub}>Legal and contact information</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.field}>
              <label className={s.fieldLabel}>Company name <span className={s.fieldRequired}>*</span></label>
              <input className={s.fieldInput} type="text" value={companyName}
                onChange={e=>setCompanyName(e.target.value)} placeholder="e.g. Acme Trading (Pty) Ltd"/>
            </div>
            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Reg number</label>
                <input className={s.fieldInput} type="text" value={regNumber} onChange={e=>setRegNumber(e.target.value)}/>
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>VAT number</label>
                <input className={s.fieldInput} type="text" value={vatNumber} onChange={e=>setVatNumber(e.target.value)}/>
              </div>
            </div>
            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Email</label>
                <input className={s.fieldInput} type="email" value={companyEmail} onChange={e=>setCompanyEmail(e.target.value)}/>
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>Telephone</label>
                <input className={s.fieldInput} type="tel" value={telephone} onChange={e=>setTelephone(e.target.value)}/>
              </div>
            </div>
            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Currency</label>
                <select className={s.fieldSelect} value={currencyCode} onChange={e=>setCurrencyCode(e.target.value)}>
                  <option value="ZAR">ZAR — Rand</option>
                  <option value="USD">USD — Dollar</option>
                  <option value="EUR">EUR — Euro</option>
                  <option value="GBP">GBP — Pound</option>
                </select>
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>Year end month</label>
                <select className={s.fieldSelect} value={yearEndMonth} onChange={e=>setYearEndMonth(+e.target.value)}>
                  {MONTHS.map((m,i) => <option key={i} value={i+1}>{m}</option>)}
                </select>
              </div>
            </div>
            <div className={s.field}>
              <label className={s.fieldLabel}>Bank name</label>
              <input className={s.fieldInput} type="text" value={bankName} onChange={e=>setBankName(e.target.value)} placeholder="e.g. FNB"/>
            </div>
            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Branch code</label>
                <input className={s.fieldInput} type="text" value={bankBranchCode} onChange={e=>setBankBranchCode(e.target.value)}/>
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>Account number</label>
                <input className={s.fieldInput} type="text" value={bankAccount} onChange={e=>setBankAccount(e.target.value)}/>
              </div>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>setStep(1)}>← Back</button>
              <button className={s.btnSave} onClick={saveDraft} disabled={busy}>Save draft</button>
              <button className={s.btnNext} onClick={saveAndNext} disabled={busy}>{busy?'Saving…':'Next →'}</button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Step 3: Periods ══ */}
      {step === 3 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Current periods</div>
            <div className={s.formCardSub}>Enter the current period for each module</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.grid2}>
              {[['GL',periodGl,setPeriodGl],['CB',periodCb,setPeriodCb],
                ['DL',periodDl,setPeriodDl],['SA',periodSa,setPeriodSa],
                ['CL',periodCl,setPeriodCl],['PU',periodPu,setPeriodPu]].map(([label,val,setter])=>(
                <div key={label} className={s.field}>
                  <label className={s.fieldLabel}>{label}</label>
                  <input className={s.fieldInput} type="number" min={1} max={12}
                    value={val} onChange={e=>setter(+e.target.value)}/>
                </div>
              ))}
            </div>
            <div className={s.field}>
              <label className={s.fieldLabel}>System year end</label>
              <input className={s.fieldInput} type="number" value={sysYearEnd}
                onChange={e=>setSysYearEnd(+e.target.value)}/>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>setStep(2)}>← Back</button>
              <button className={s.btnNext} onClick={saveAndNext} disabled={busy}>{busy?'Saving…':'Next →'}</button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Step 4: Locations ══ */}
      {step === 4 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Locations</div>
            <div className={s.formCardSub}>Add all company locations / warehouses</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.repeatSection}>
              {locs.map((loc, i) => (
                <div key={i} className={s.repeatCard}>
                  <div className={s.repeatCardTitle}>
                    Location {i+1}
                    {locs.length > 1 && (
                      <button className={s.repeatRemove} onClick={()=>remLoc(i)}>×</button>
                    )}
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Loc code <span className={s.fieldRequired}>*</span></label>
                      <input className={s.fieldInput} type="text" maxLength={3}
                        value={loc.loc} onChange={e=>setLoc(i,'loc',e.target.value.toUpperCase())} placeholder="001"/>
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Whs code</label>
                      <input className={s.fieldInput} type="text" maxLength={3}
                        value={loc.whs} onChange={e=>setLoc(i,'whs',e.target.value.toUpperCase())} placeholder="001"/>
                    </div>
                  </div>
                  <div className={s.field}>
                    <label className={s.fieldLabel}>Location name</label>
                    <input className={s.fieldInput} type="text"
                      value={loc.locName} onChange={e=>setLoc(i,'locName',e.target.value)} placeholder="e.g. Main Warehouse"/>
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Region</label>
                      <input className={s.fieldInput} type="text" maxLength={3}
                        value={loc.region} onChange={e=>setLoc(i,'region',e.target.value.toUpperCase())}/>
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Stock location</label>
                      <select className={s.fieldSelect} value={loc.stockLoc?'Y':'N'}
                        onChange={e=>setLoc(i,'stockLoc',e.target.value==='Y')}>
                        <option value="Y">Yes</option>
                        <option value="N">No</option>
                      </select>
                    </div>
                  </div>
                  <div className={s.field}>
                    <label className={s.fieldLabel}>Physical address</label>
                    <input className={s.fieldInput} type="text"
                      value={loc.physicalAddr1} onChange={e=>setLoc(i,'physicalAddr1',e.target.value)} placeholder="Street address"/>
                  </div>
                </div>
              ))}
              <button className={s.addBtn} onClick={addLoc}>+ Add location</button>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>setStep(3)}>← Back</button>
              <button className={s.btnNext} onClick={saveAndNext} disabled={busy}>{busy?'Saving…':'Next →'}</button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Step 5: Users ══ */}
      {step === 5 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Base users</div>
            <div className={s.formCardSub}>Add the users who will have system access</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.repeatSection}>
              {users.map((u, i) => (
                <div key={i} className={s.repeatCard}>
                  <div className={s.repeatCardTitle}>
                    User {i+1}
                    {users.length > 1 && (
                      <button className={s.repeatRemove} onClick={()=>remUser(i)}>×</button>
                    )}
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Username <span className={s.fieldRequired}>*</span></label>
                      <input className={s.fieldInput} type="text" maxLength={10}
                        value={u.username} onChange={e=>setUser(i,'username',e.target.value)}/>
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Full name</label>
                      <input className={s.fieldInput} type="text"
                        value={u.fullName} onChange={e=>setUser(i,'fullName',e.target.value)}/>
                    </div>
                  </div>
                  <div className={s.field}>
                    <label className={s.fieldLabel}>Email</label>
                    <input className={s.fieldInput} type="email"
                      value={u.email} onChange={e=>setUser(i,'email',e.target.value)}/>
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Default loc</label>
                      <input className={s.fieldInput} type="text" maxLength={3}
                        value={u.defaultLoc} onChange={e=>setUser(i,'defaultLoc',e.target.value.toUpperCase())}
                        placeholder={locs[0]?.loc || '001'}/>
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Access group</label>
                      <select className={s.fieldSelect} value={u.accessGrp}
                        onChange={e=>setUser(i,'accessGrp',e.target.value)}>
                        <option value="Z0">Z0 — System Admin</option>
                        <option value="A1">A1 — Administrator</option>
                        <option value="U1">U1 — Standard User</option>
                        <option value="V1">V1 — View Only</option>
                      </select>
                    </div>
                  </div>
                </div>
              ))}
              <button className={s.addBtn} onClick={addUser}>+ Add user</button>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>setStep(4)}>← Back</button>
              <button className={s.btnSave} onClick={saveDraft} disabled={busy}>Save draft</button>
              <button className={s.btnSubmit} onClick={handleSubmit} disabled={busy}>
                {busy ? 'Submitting…' : '✓ Submit for approval'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
