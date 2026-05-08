import React, { useState, useEffect, useRef } from 'react'
import { Sparkles, X, Wand2, Paperclip, FileText, Download, Trash2 } from 'lucide-react'
import { createRegistration, updateRegistration, submitRegistration, getRegistration, getAiSuggestions,
         listDocuments, uploadDocument, deleteDocument, getDocumentUrl } from '../api/portalApi.js'
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

// ── Validation — JS mirror of Java ValidationService / Genero sy_lib.4gl ──────
// Character rules ported from lf_invalid_chars_in_string (sy_lib.4gl)
const CHAR_RULES = {
  C:    /^[A-Z0-9#.\-/+=[\]:]*$/,      // Codes/key fields — uppercase + digits + punctuation
  D:    /^[A-Za-z0-9 \-_.+*=:#!$%@&[\]()/]*$/,  // Descriptions — no commas (breaks CSV)
  E:    /^[A-Za-z0-9.@\-_,]*$/,        // Email addresses
  T:    /^[0-9() /]*$/,                 // Telephone numbers
  N:    /^[0-9.]*$/,                    // Numeric
  VN:   /^[0-9() /]*$/,                 // VAT Normal
  user: /^[a-z0-9\-_.]*$/,             // Usernames — lowercase only
}

const TYPE_HINTS = {
  C:    'uppercase letters, digits and # . - / + = [ ] :',
  D:    'letters, digits, spaces and common punctuation (no commas)',
  E:    'letters, digits, @ . - _ and comma',
  T:    'digits, spaces, ( ) and /',
  N:    'digits and decimal point only',
  VN:   'digits, spaces, ( ) and /',
  user: 'lowercase letters, digits, hyphen, underscore and dot',
}

function validateField(label, value, type, required, maxLen) {
  const v = (value || '').trim()
  if (!v) return required ? `${label} is required` : null
  if (maxLen && value.length > maxLen) return `${label} must be ${maxLen} characters or fewer`
  if (CHAR_RULES[type] && !CHAR_RULES[type].test(v))
    return `${label}: allowed characters are ${TYPE_HINTS[type]}`
  return null
}

function collectErrors(rules) {
  const errs = {}
  for (const [key, args] of Object.entries(rules)) {
    const msg = validateField(...args)
    if (msg) errs[key] = msg
  }
  return errs
}

// ── Component ─────────────────────────────────────────────────────────────────
export default function RegistrationForm({ regId: initialRegId, onBack, onDone }) {
  const [step,        setStep]        = useState(1)
  const [regId,       setRegId]       = useState(initialRegId || null)
  const [busy,        setBusy]        = useState(false)
  const [loading,     setLoading]     = useState(!!initialRegId)
  const [err,         setErr]         = useState(null)
  const [fieldErrors, setFieldErrors] = useState({})

  // Step 1
  const [pkg,        setPkg]        = useState('LITE')
  const [numUsers,   setNumUsers]   = useState(5)
  const [standalone, setStandalone] = useState(true)

  // Step 2
  const [companyName,    setCompanyName]    = useState('')
  const [regNumber,      setRegNumber]      = useState('')
  const [vatNumber,      setVatNumber]      = useState('')
  const [companyEmail,   setCompanyEmail]   = useState('')
  const [telephone,      setTelephone]      = useState('')
  const [currencyCode,   setCurrencyCode]   = useState('ZAR')
  const [yearEndMonth,   setYearEndMonth]   = useState(2)
  const [vatRate,        setVatRate]        = useState(15)
  const [bankName,       setBankName]       = useState('')
  const [bankBranch,     setBankBranch]     = useState('')
  const [bankBranchCode, setBankBranchCode] = useState('')
  const [bankAccount,    setBankAccount]    = useState('')

  // Step 3
  const [periodGl,   setPeriodGl]   = useState(1)
  const [periodCb,   setPeriodCb]   = useState(1)
  const [periodDl,   setPeriodDl]   = useState(1)
  const [periodSa,   setPeriodSa]   = useState(1)
  const [periodCl,   setPeriodCl]   = useState(1)
  const [periodPu,   setPeriodPu]   = useState(1)
  const [sysYearEnd, setSysYearEnd] = useState(new Date().getFullYear())

  // Step 4
  const [locs,  setLocs]  = useState([emptyLoc()])

  // Step 5
  const [users, setUsers] = useState([emptyUser()])

  // Documents
  const [docs,          setDocs]          = useState([])
  const [docUploading,  setDocUploading]  = useState(false)
  const fileInputRef = useRef(null)

  useEffect(() => {
    if (regId) listDocuments(regId).then(setDocs).catch(() => {})
  }, [regId])

  async function handleFileChange(e) {
    const file = e.target.files[0]
    if (!file || !regId) return
    setDocUploading(true)
    try {
      const doc = await uploadDocument(regId, file)
      setDocs(prev => [doc, ...prev])
    } catch (ex) {
      setErr('Upload failed: ' + (ex.response?.data?.message || ex.message))
    } finally { setDocUploading(false); e.target.value = '' }
  }

  async function handleDocDelete(docId) {
    if (!regId) return
    try {
      await deleteDocument(regId, docId)
      setDocs(prev => prev.filter(d => d.id !== docId))
    } catch (ex) {
      setErr('Delete failed: ' + (ex.response?.data?.message || ex.message))
    }
  }

  // AI assistant
  const [aiOpen,        setAiOpen]        = useState(false)
  const [aiDescription, setAiDescription] = useState('')
  const [aiLoading,     setAiLoading]     = useState(false)
  const [aiSuggestion,  setAiSuggestion]  = useState(null)
  const [aiError,       setAiError]       = useState(null)

  // Load existing draft when editing
  useEffect(() => {
    if (!initialRegId) return
    setLoading(true)
    getRegistration(initialRegId)
      .then(d => {
        setPkg(d.packageType || 'LITE')
        setNumUsers(d.numUsers || 5)
        setStandalone(d.standalone !== false)
        setCompanyName(d.companyName || '')
        setRegNumber(d.regNumber || '')
        setVatNumber(d.vatNumber || '')
        setCompanyEmail(d.companyEmail || '')
        setTelephone(d.telephone || '')
        setCurrencyCode(d.currencyCode || 'ZAR')
        setYearEndMonth(d.yearEndMonth || 2)
        setVatRate(d.vatRate || 15)
        setBankName(d.bankName || '')
        setBankBranch(d.bankBranch || '')
        setBankBranchCode(d.bankBranchCode || '')
        setBankAccount(d.bankAccount || '')
        setPeriodGl(d.periodGl || 1)
        setPeriodCb(d.periodCb || 1)
        setPeriodDl(d.periodDl || 1)
        setPeriodSa(d.periodSa || 1)
        setPeriodCl(d.periodCl || 1)
        setPeriodPu(d.periodPu || 1)
        setSysYearEnd(d.systemYearEnd || new Date().getFullYear())
        if (d.locations?.length) setLocs(d.locations.map(l => ({
          loc: l.loc || '', whs: l.whs || '001', locName: l.locName || '',
          region: l.region || '', stockLoc: l.stockLoc !== false,
          physicalAddr1: l.physicalAddr1 || '', physicalAddr2: l.physicalAddr2 || '',
          physicalAddr3: l.physicalAddr3 || '', physicalAddr4: l.physicalAddr4 || '',
        })))
        if (d.users?.length) setUsers(d.users.map(u => ({
          username: u.username || '', fullName: u.fullName || '',
          email: u.email || '', defaultLoc: u.defaultLoc || '', accessGrp: u.accessGrp || 'A1',
        })))
      })
      .catch(() => setErr('Failed to load registration data'))
      .finally(() => setLoading(false))
  }, [initialRegId])

  // ── AI assistant ──────────────────────────────────────────────────────────
  async function askAi() {
    if (!aiDescription.trim()) return
    setAiLoading(true); setAiError(null); setAiSuggestion(null)
    try {
      const data = await getAiSuggestions(aiDescription.trim())
      setAiSuggestion(data)
    } catch (e) {
      setAiError(e.response?.data?.message || 'AI request failed — check your API key and try again')
    } finally { setAiLoading(false) }
  }

  function applyAiSuggestion(s) {
    if (!s) return
    if (s.packageType)   setPkg(s.packageType)
    if (s.numUsers)      setNumUsers(s.numUsers)
    if (s.standalone != null) setStandalone(s.standalone)
    if (s.companyName)   setCompanyName(s.companyName)
    if (s.regNumber)     setRegNumber(s.regNumber)
    if (s.vatNumber)     setVatNumber(s.vatNumber)
    if (s.currencyCode)  setCurrencyCode(s.currencyCode)
    if (s.yearEndMonth)  setYearEndMonth(s.yearEndMonth)
    if (s.locations?.length) setLocs(s.locations.map(l => ({
      loc:           l.loc || '',
      whs:           l.whs || '001',
      locName:       l.locName || '',
      region:        l.region || '',
      stockLoc:      l.stockLoc !== false,
      physicalAddr1: '', physicalAddr2: '', physicalAddr3: '', physicalAddr4: '',
    })))
    if (s.users?.length) setUsers(s.users.map(u => ({
      username:   u.username || '',
      fullName:   u.fullName || '',
      email:      '',
      defaultLoc: s.locations?.[0]?.loc || '',
      accessGrp:  u.accessGrp || 'A1',
    })))
    setAiOpen(false)
    setFieldErrors({})
  }

  // ── Payload ───────────────────────────────────────────────────────────────
  function buildPayload() {
    return {
      packageType: pkg, numUsers, standalone, masterOrSlave: standalone ? 'MASTER' : 'SLAVE',
      companyName, regNumber, vatNumber, companyEmail, telephone, currencyCode,
      yearEndMonth, vatRate, bankName, bankBranch, bankBranchCode, bankAccount,
      periodGl, periodCb, periodDl, periodSa, periodCl, periodPu,
      systemYearEnd: sysYearEnd,
      locations: locs.filter(l => l.loc?.trim()),
      users:     users.filter(u => u.username?.trim()),
    }
  }

  // ── Step validators ───────────────────────────────────────────────────────
  function validateStep2() {
    return collectErrors({
      companyName:    ['Company name',   companyName,    'D',  true,  100],
      companyEmail:   ['Company email',  companyEmail,   'E',  true,  100],
      telephone:      ['Telephone',      telephone,      'T',  true,   30],
      regNumber:      ['Reg number',     regNumber,      'D',  false,  30],
      vatNumber:      ['VAT number',     vatNumber,      'VN', false,  30],
      bankName:       ['Bank name',      bankName,       'D',  false,  60],
      bankBranch:     ['Branch name',    bankBranch,     'D',  false,  60],
      bankBranchCode: ['Branch code',    bankBranchCode, 'N',  false,  20],
      bankAccount:    ['Account number', bankAccount,    'N',  false,  30],
    })
  }

  function validateStep3() {
    const errs = {}
    const year = Number(sysYearEnd)
    if (!sysYearEnd || year < 1990 || year > 2099)
      errs.sysYearEnd = 'System year end must be a valid year (1990–2099)'
    ;[['periodGl',periodGl],['periodCb',periodCb],['periodDl',periodDl],
      ['periodSa',periodSa],['periodCl',periodCl],['periodPu',periodPu]].forEach(([k,v]) => {
      if (v < 1 || v > 12) errs[k] = 'Period must be between 1 and 12'
    })
    return errs
  }

  function validateStep4() {
    const errs = {}
    locs.forEach((loc, i) => Object.assign(errs, collectErrors({
      [`loc_${i}_loc`]:          [`Location ${i+1} code`,    loc.loc,          'C', true,   3],
      [`loc_${i}_whs`]:          [`Location ${i+1} whs`,     loc.whs,          'C', false,  3],
      [`loc_${i}_locName`]:      [`Location ${i+1} name`,    loc.locName,      'D', false, 60],
      [`loc_${i}_region`]:       [`Location ${i+1} region`,  loc.region,       'C', false, 40],
      [`loc_${i}_physicalAddr1`]:[`Location ${i+1} address`, loc.physicalAddr1,'D', false, 60],
    })))
    return errs
  }

  function validateStep5() {
    const errs = {}
    users.forEach((u, i) => Object.assign(errs, collectErrors({
      [`user_${i}_username`]: [`User ${i+1} username`,  u.username, 'user', true,  30],
      [`user_${i}_fullName`]: [`User ${i+1} full name`, u.fullName, 'D',   false,  80],
      [`user_${i}_email`]:    [`User ${i+1} email`,     u.email,    'E',   false, 100],
      [`user_${i}_defaultLoc`]:[`User ${i+1} default loc`, u.defaultLoc, 'C', false, 3],
    })))
    return errs
  }

  // ── Navigation ────────────────────────────────────────────────────────────
  function runValidation() {
    if (step === 2) return validateStep2()
    if (step === 3) return validateStep3()
    if (step === 4) return validateStep4()
    if (step === 5) return validateStep5()
    return {}
  }

  function clearStep() { setFieldErrors({}); setErr(null) }

  async function saveAndNext() {
    const errs = runValidation()
    setFieldErrors(errs)
    if (Object.keys(errs).length > 0) { setErr('Please fix the highlighted errors before continuing'); return }
    setErr(null)
    setBusy(true)
    try {
      const saved = regId
        ? await updateRegistration(regId, buildPayload())
        : await createRegistration(buildPayload())
      if (!regId) setRegId(saved.id)
      setStep(prev => prev + 1)
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to save')
    } finally { setBusy(false) }
  }

  async function handleSubmit() {
    const errs = validateStep5()
    setFieldErrors(errs)
    if (Object.keys(errs).length > 0) { setErr('Please fix the highlighted errors before submitting'); return }
    setErr(null)
    setBusy(true)
    try {
      const saved = regId
        ? await updateRegistration(regId, buildPayload())
        : await createRegistration(buildPayload())
      await submitRegistration(regId || saved.id)
      onDone()
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to submit')
    } finally { setBusy(false) }
  }

  async function saveDraft() {
    setBusy(true); setErr(null)
    try {
      const saved = regId
        ? await updateRegistration(regId, buildPayload())
        : await createRegistration(buildPayload())
      if (!regId) setRegId(saved.id)
      onDone()
    } catch (e) {
      setErr(e.response?.data?.message || 'Failed to save draft')
    } finally { setBusy(false) }
  }

  // Inline error helpers
  function fe(key) {
    return fieldErrors[key]
      ? <div className={s.fieldError}>{fieldErrors[key]}</div>
      : null
  }
  function fi(key) {
    return fieldErrors[key] ? `${s.fieldInput} ${s.fieldInputErr}` : s.fieldInput
  }
  function clearErr(key) {
    setFieldErrors(prev => { const n = {...prev}; delete n[key]; return n })
  }

  // Loc/User helpers
  const setLoc  = (i, k, v) => setLocs(prev => prev.map((l, idx) => idx===i ? {...l,[k]:v} : l))
  const addLoc  = () => setLocs(prev => [...prev, emptyLoc()])
  const remLoc  = i  => setLocs(prev => prev.filter((_,idx) => idx!==i))
  const setUser = (i, k, v) => setUsers(prev => prev.map((u, idx) => idx===i ? {...u,[k]:v} : u))
  const addUser = () => setUsers(prev => [...prev, emptyUser()])
  const remUser = i  => setUsers(prev => prev.filter((_,idx) => idx!==i))

  if (loading) return (
    <div className={s.page}>
      <div className={s.alertOk}>Loading draft registration…</div>
    </div>
  )

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}<button className={s.alertClose} onClick={()=>setErr(null)}>×</button></div>}

      {/* ── AI assistant floating button ── */}
      <button className={s.aiTrigger} onClick={() => setAiOpen(true)} title="AI form assistant">
        <Sparkles size={18}/>
        <span>AI Assistant</span>
      </button>

      {/* ── AI assistant slide-in panel ── */}
      {aiOpen && (
        <div className={s.aiOverlay} onClick={() => setAiOpen(false)}>
          <div className={s.aiPanel} onClick={e => e.stopPropagation()}>
            <div className={s.aiHeader}>
              <div className={s.aiTitle}>
                <Sparkles size={18}/> AI Registration Assistant
              </div>
              <button className={s.aiClose} onClick={() => setAiOpen(false)}><X size={18}/></button>
            </div>

            <div className={s.aiBody}>
              <p className={s.aiHint}>
                Describe the company in plain language and Claude will suggest values for the entire form.
              </p>
              <textarea
                className={s.aiTextarea}
                rows={5}
                placeholder="e.g. We're registering a clothing retailer based in Cape Town with 12 staff. They need a Lite package, stock at one warehouse, and a February year-end."
                value={aiDescription}
                onChange={e => setAiDescription(e.target.value)}
              />
              <button className={s.aiSubmit} onClick={askAi} disabled={aiLoading || !aiDescription.trim()}>
                {aiLoading ? 'Thinking…' : <><Wand2 size={15}/> Generate suggestions</>}
              </button>

              {aiError && <div className={s.aiError}>{aiError}</div>}

              {aiSuggestion && (
                <div className={s.aiResult}>
                  <div className={s.aiResultTitle}>Claude suggests:</div>

                  {aiSuggestion.reasoning && (
                    <p className={s.aiReasoning}>{aiSuggestion.reasoning}</p>
                  )}

                  <div className={s.aiFields}>
                    {aiSuggestion.packageType && (
                      <div className={s.aiField}>
                        <span className={s.aiFieldLabel}>Package</span>
                        <span className={s.aiFieldValue}>{aiSuggestion.packageType}</span>
                      </div>
                    )}
                    {aiSuggestion.numUsers && (
                      <div className={s.aiField}>
                        <span className={s.aiFieldLabel}>Users</span>
                        <span className={s.aiFieldValue}>{aiSuggestion.numUsers}</span>
                      </div>
                    )}
                    {aiSuggestion.companyName && (
                      <div className={s.aiField}>
                        <span className={s.aiFieldLabel}>Company name</span>
                        <span className={s.aiFieldValue}>{aiSuggestion.companyName}</span>
                      </div>
                    )}
                    {aiSuggestion.currencyCode && (
                      <div className={s.aiField}>
                        <span className={s.aiFieldLabel}>Currency</span>
                        <span className={s.aiFieldValue}>{aiSuggestion.currencyCode}</span>
                      </div>
                    )}
                    {aiSuggestion.yearEndMonth && (
                      <div className={s.aiField}>
                        <span className={s.aiFieldLabel}>Year end</span>
                        <span className={s.aiFieldValue}>Month {aiSuggestion.yearEndMonth}</span>
                      </div>
                    )}
                    {aiSuggestion.locations?.map((loc, i) => (
                      <div key={i} className={s.aiField}>
                        <span className={s.aiFieldLabel}>Location {i+1}</span>
                        <span className={s.aiFieldValue}>{loc.loc} — {loc.locName}</span>
                      </div>
                    ))}
                    {aiSuggestion.users?.map((u, i) => (
                      <div key={i} className={s.aiField}>
                        <span className={s.aiFieldLabel}>User {i+1}</span>
                        <span className={s.aiFieldValue}>{u.username} ({u.accessGrp})</span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>

            {/* Sticky footer — always visible, never scrolled out of view */}
            {aiSuggestion && (
              <div className={s.aiFooter}>
                <button className={s.aiDecline} onClick={() => { setAiSuggestion(null); setAiDescription('') }}>
                  Discard
                </button>
                <button className={s.aiApply} onClick={() => applyAiSuggestion(aiSuggestion)}>
                  <Wand2 size={15}/> Apply to form
                </button>
              </div>
            )}
          </div>
        </div>
      )}

      {/* Step bar */}
      <div className={s.stepBar}>
        {STEPS.map((st, i) => {
          const done = step > st.num; const active = step === st.num
          return (
            <div key={st.num} className={s.stepItem}>
              {i > 0 && <span className={s.stepArrow}>›</span>}
              <div className={`${s.stepNum} ${active?s.stepNumActive:''} ${done?s.stepNumDone:''}`}>
                {done ? '✓' : st.num}
              </div>
              <span className={`${s.stepLabel} ${active?s.stepLabelActive:''} ${done?s.stepLabelDone:''}`}>
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
                { id:'LITE', name:'Xact Lite', desc:'SME focused · 1-step approval (XactERP only)',           check:'✓ Approved by XactERP' },
                { id:'PRO',  name:'Xact Pro',  desc:'Enterprise · 2-step approval (Imply → XactERP)', check:'✓ Imply review, then XactERP approval' },
              ].map(p => (
                <div key={p.id} className={`${s.pkgCard} ${pkg===p.id?s.pkgCardActive:''}`} onClick={()=>setPkg(p.id)}>
                  <div className={s.pkgName}>{p.name}</div>
                  <div className={s.pkgDesc}>{p.desc}</div>
                  <div className={s.pkgCheck}>{p.check}</div>
                </div>
              ))}
            </div>
            <div className={s.field}>
              <label className={s.fieldLabel}>Number of users</label>
              <input className={s.fieldInput} type="number" min={1} max={500}
                value={numUsers} onChange={e=>setNumUsers(Math.max(1,Math.min(500,+e.target.value)))}/>
            </div>
            <div className={s.field}>
              <label className={s.fieldLabel}>Company type</label>
              <select className={s.fieldSelect} value={standalone?'Y':'N'} onChange={e=>setStandalone(e.target.value==='Y')}>
                <option value="Y">Standalone company</option>
                <option value="N">Linked to master company</option>
              </select>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={onBack}>Cancel</button>
              <button className={s.btnSave} onClick={saveDraft} disabled={busy}>Save draft</button>
              <button className={s.btnNext} onClick={()=>{clearStep();setStep(2)}} disabled={busy}>Next →</button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Step 2: Company ══ */}
      {step === 2 && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}>Company details</div>
            <div className={s.formCardSub}>Legal and contact information</div>
          </div>
          <div className={s.formCardBody}>

            <div className={s.field}>
              <label className={s.fieldLabel}>Company name <span className={s.fieldRequired}>*</span></label>
              <input className={fi('companyName')} type="text" maxLength={100}
                value={companyName} onChange={e=>{setCompanyName(e.target.value);clearErr('companyName')}}
                placeholder="e.g. Acme Trading (Pty) Ltd"/>
              {fe('companyName')}
            </div>

            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Reg number</label>
                <input className={fi('regNumber')} type="text" maxLength={30}
                  value={regNumber} onChange={e=>{setRegNumber(e.target.value);clearErr('regNumber')}}
                  placeholder="2020/123456/07"/>
                {fe('regNumber')}
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>VAT number</label>
                <input className={fi('vatNumber')} type="text" maxLength={30}
                  value={vatNumber} onChange={e=>{setVatNumber(e.target.value.replace(/[^0-9() /]/g,''));clearErr('vatNumber')}}
                  placeholder="4123456789"/>
                {fe('vatNumber')}
              </div>
            </div>

            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Company email <span className={s.fieldRequired}>*</span></label>
                <input className={fi('companyEmail')} type="text" maxLength={100}
                  value={companyEmail} onChange={e=>{setCompanyEmail(e.target.value);clearErr('companyEmail')}}
                  placeholder="info@company.co.za"/>
                {fe('companyEmail')}
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>Telephone <span className={s.fieldRequired}>*</span></label>
                <input className={fi('telephone')} type="text" maxLength={30}
                  value={telephone} onChange={e=>{setTelephone(e.target.value.replace(/[^0-9() /]/g,''));clearErr('telephone')}}
                  placeholder="011 123 4567"/>
                {fe('telephone')}
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
              <input className={fi('bankName')} type="text" maxLength={60}
                value={bankName} onChange={e=>{setBankName(e.target.value);clearErr('bankName')}}
                placeholder="e.g. FNB"/>
              {fe('bankName')}
            </div>

            <div className={s.grid2}>
              <div className={s.field}>
                <label className={s.fieldLabel}>Branch name</label>
                <input className={fi('bankBranch')} type="text" maxLength={60}
                  value={bankBranch} onChange={e=>{setBankBranch(e.target.value);clearErr('bankBranch')}}/>
                {fe('bankBranch')}
              </div>
              <div className={s.field}>
                <label className={s.fieldLabel}>Branch code</label>
                <input className={fi('bankBranchCode')} type="text" maxLength={20}
                  value={bankBranchCode} onChange={e=>{setBankBranchCode(e.target.value.replace(/[^0-9.]/g,''));clearErr('bankBranchCode')}}
                  placeholder="250655"/>
                {fe('bankBranchCode')}
              </div>
            </div>

            <div className={s.field}>
              <label className={s.fieldLabel}>Account number</label>
              <input className={fi('bankAccount')} type="text" maxLength={30}
                value={bankAccount} onChange={e=>{setBankAccount(e.target.value.replace(/[^0-9.]/g,''));clearErr('bankAccount')}}/>
              {fe('bankAccount')}
            </div>

            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>{clearStep();setStep(1)}}>← Back</button>
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
            <div className={s.formCardSub}>Enter the current open period for each module (1 – 12)</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.grid3}>
              {[
                ['GL','periodGl',periodGl,setPeriodGl],
                ['CB','periodCb',periodCb,setPeriodCb],
                ['DL','periodDl',periodDl,setPeriodDl],
                ['SA','periodSa',periodSa,setPeriodSa],
                ['CL','periodCl',periodCl,setPeriodCl],
                ['PU','periodPu',periodPu,setPeriodPu],
              ].map(([label,key,val,setter]) => (
                <div key={label} className={s.field}>
                  <label className={s.fieldLabel}>{label}</label>
                  <input className={fi(key)} type="number" min={1} max={12}
                    value={val} onChange={e=>{setter(Math.max(1,Math.min(12,+e.target.value)));clearErr(key)}}/>
                  {fe(key)}
                </div>
              ))}
              <div className={s.field}>
                <label className={s.fieldLabel}>Year end <span className={s.fieldRequired}>*</span></label>
                <input className={fi('sysYearEnd')} type="number" min={1990} max={2099}
                  value={sysYearEnd} onChange={e=>{setSysYearEnd(+e.target.value);clearErr('sysYearEnd')}}/>
                {fe('sysYearEnd')}
              </div>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>{clearStep();setStep(2)}}>← Back</button>
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
                    {locs.length > 1 && <button className={s.repeatRemove} onClick={()=>remLoc(i)}>×</button>}
                  </div>
                  <div className={s.gridCode}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Loc <span className={s.fieldRequired}>*</span></label>
                      <input className={fi(`loc_${i}_loc`)} type="text" maxLength={3}
                        value={loc.loc}
                        onChange={e=>{setLoc(i,'loc',e.target.value.toUpperCase().replace(/[^A-Z0-9#.\-/+=[\]:]/g,''));clearErr(`loc_${i}_loc`)}}
                        placeholder="001"/>
                      {fe(`loc_${i}_loc`)}
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Whs</label>
                      <input className={fi(`loc_${i}_whs`)} type="text" maxLength={3}
                        value={loc.whs}
                        onChange={e=>{setLoc(i,'whs',e.target.value.toUpperCase().replace(/[^A-Z0-9#.\-/+=[\]:]/g,''));clearErr(`loc_${i}_whs`)}}
                        placeholder="001"/>
                      {fe(`loc_${i}_whs`)}
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Location name</label>
                      <input className={fi(`loc_${i}_locName`)} type="text" maxLength={60}
                        value={loc.locName}
                        onChange={e=>{setLoc(i,'locName',e.target.value);clearErr(`loc_${i}_locName`)}}
                        placeholder="e.g. Main Warehouse"/>
                      {fe(`loc_${i}_locName`)}
                    </div>
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Region</label>
                      <input className={fi(`loc_${i}_region`)} type="text" maxLength={40}
                        value={loc.region}
                        onChange={e=>{setLoc(i,'region',e.target.value.toUpperCase().replace(/[^A-Z0-9#.\-/+=[\]:]/g,''));clearErr(`loc_${i}_region`)}}/>
                      {fe(`loc_${i}_region`)}
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
                    <input className={fi(`loc_${i}_physicalAddr1`)} type="text" maxLength={60}
                      value={loc.physicalAddr1}
                      onChange={e=>{setLoc(i,'physicalAddr1',e.target.value);clearErr(`loc_${i}_physicalAddr1`)}}
                      placeholder="Street address"/>
                    {fe(`loc_${i}_physicalAddr1`)}
                  </div>
                </div>
              ))}
              <button className={s.addBtn} onClick={addLoc}>+ Add location</button>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>{clearStep();setStep(3)}}>← Back</button>
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
                    {users.length > 1 && <button className={s.repeatRemove} onClick={()=>remUser(i)}>×</button>}
                  </div>
                  <div className={s.grid2}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Username <span className={s.fieldRequired}>*</span></label>
                      <input className={fi(`user_${i}_username`)} type="text" maxLength={30}
                        value={u.username}
                        onChange={e=>{setUser(i,'username',e.target.value.toLowerCase().replace(/[^a-z0-9\-_.]/g,''));clearErr(`user_${i}_username`)}}
                        placeholder="e.g. john.smith"/>
                      {fe(`user_${i}_username`)}
                    </div>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Full name</label>
                      <input className={fi(`user_${i}_fullName`)} type="text" maxLength={80}
                        value={u.fullName}
                        onChange={e=>{setUser(i,'fullName',e.target.value);clearErr(`user_${i}_fullName`)}}/>
                      {fe(`user_${i}_fullName`)}
                    </div>
                  </div>
                  <div className={s.gridCode}>
                    <div className={s.field}>
                      <label className={s.fieldLabel}>Loc</label>
                      <input className={fi(`user_${i}_defaultLoc`)} type="text" maxLength={3}
                        value={u.defaultLoc}
                        onChange={e=>{setUser(i,'defaultLoc',e.target.value.toUpperCase().replace(/[^A-Z0-9#.\-/+=[\]:]/g,''));clearErr(`user_${i}_defaultLoc`)}}
                        placeholder={locs[0]?.loc || '001'}/>
                      {fe(`user_${i}_defaultLoc`)}
                    </div>
                    <div className={s.field} style={{gridColumn:'span 2'}}>
                      <label className={s.fieldLabel}>Email</label>
                      <input className={fi(`user_${i}_email`)} type="text" maxLength={100}
                        value={u.email}
                        onChange={e=>{setUser(i,'email',e.target.value);clearErr(`user_${i}_email`)}}
                        placeholder="john@company.co.za"/>
                      {fe(`user_${i}_email`)}
                    </div>
                  </div>
                  <div className={s.field}>
                    <label className={s.fieldLabel}>Access group</label>
                    <select className={s.fieldSelect} value={u.accessGrp} onChange={e=>setUser(i,'accessGrp',e.target.value)}>
                      <option value="Z0">Z0 — System Admin</option>
                      <option value="A1">A1 — Administrator</option>
                      <option value="U1">U1 — Standard User</option>
                      <option value="V1">V1 — View Only</option>
                    </select>
                  </div>
                </div>
              ))}
              <button className={s.addBtn} onClick={addUser}>+ Add user</button>
            </div>
            <div className={s.formNav}>
              <button className={s.btnBack} onClick={()=>{clearStep();setStep(4)}}>← Back</button>
              <button className={s.btnSave} onClick={saveDraft} disabled={busy}>Save draft</button>
              <button className={s.btnSubmit} onClick={handleSubmit} disabled={busy}>
                {busy ? 'Submitting…' : '✓ Submit for approval'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ══ Supporting Documents (shown once regId exists) ══ */}
      {regId && (
        <div className={s.formCard}>
          <div className={s.formCardHead}>
            <div className={s.formCardTitle}><Paperclip size={15} style={{verticalAlign:'middle',marginRight:6}}/>Supporting documents</div>
            <div className={s.formCardSub}>Attach CIPC registration, tax clearance, MOI or other supporting docs</div>
          </div>
          <div className={s.formCardBody}>
            <div className={s.docList}>
              {docs.length === 0 && !docUploading && (
                <div className={s.docEmpty}>No documents attached yet</div>
              )}
              {docs.map(d => (
                <div key={d.id} className={s.docRow}>
                  <FileText size={14} style={{color:'var(--color-primary)',flexShrink:0}}/>
                  <span className={s.docName}>{d.fileName}</span>
                  <span className={s.docMeta}>{d.fileSize ? (d.fileSize / 1024).toFixed(0) + ' KB' : ''}</span>
                  <a href={getDocumentUrl(regId, d.id)} download={d.fileName}
                     className={s.docDownload} target="_blank" rel="noreferrer">
                    <Download size={12}/> Download
                  </a>
                  <button className={s.docDelete} onClick={() => handleDocDelete(d.id)} title="Remove document">
                    <Trash2 size={12}/>
                  </button>
                </div>
              ))}
              {docUploading && <div className={s.docEmpty}>Uploading…</div>}
            </div>
            <input ref={fileInputRef} type="file" style={{display:'none'}}
              accept=".pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png,.txt"
              onChange={handleFileChange}/>
            <button className={s.docUploadBtn} onClick={() => fileInputRef.current?.click()} disabled={docUploading}>
              <Paperclip size={14}/> {docUploading ? 'Uploading…' : 'Attach document'}
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
