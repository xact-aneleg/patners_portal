import React, { useState, useEffect } from 'react'
import { getRegistration, submitRegistration, getConversionStatus } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

const EVENT_COLORS = {
  SUBMITTED:'#39B54A', APPROVED_IMPLY:'#39B54A', DECLINED_IMPLY:'#C62828',
  APPROVED_XACT:'#39B54A', DECLINED_XACT:'#C62828',
  CONVERSION_STARTED:'#1565C0', LIVE:'#39B54A',
}
const EVENT_LABELS = {
  SUBMITTED:'Registration submitted', APPROVED_IMPLY:'Approved by Imply',
  DECLINED_IMPLY:'Declined by Imply', APPROVED_XACT:'Approved by XactERP',
  DECLINED_XACT:'Declined by XactERP', CONVERSION_STARTED:'Data conversion started',
  LIVE:'Company is now live',
}

function fmt(dt) {
  if (!dt) return '—'
  return new Date(dt).toLocaleString('en-ZA', { dateStyle:'medium', timeStyle:'short' })
}

export default function RegistrationDetail({ regId, onBack }) {
  const [reg,  setReg]  = useState(null)
  const [job,  setJob]  = useState(null)
  const [busy, setBusy] = useState(false)
  const [toast, setToast] = useState(null)

  useEffect(() => {
    getRegistration(regId).then(setReg)
  }, [regId])

  useEffect(() => {
    if (reg && (reg.status === 'CONVERTING' || reg.status === 'LIVE')) {
      getConversionStatus(regId).then(setJob).catch(() => {})
    }
  }, [reg])

  async function handleSubmit() {
    setBusy(true)
    try {
      await submitRegistration(regId)
      setToast({ type:'success', msg:'Submitted for approval successfully.' })
      setReg(await getRegistration(regId))
    } catch(e) {
      setToast({ type:'error', msg: e.response?.data?.message || 'Submit failed' })
    } finally { setBusy(false) }
  }

  if (!reg) return <div className={s.empty}>Loading…</div>

  return (
    <div>
      {toast && (
        <div className={`${s.toast} ${s['t_'+toast.type]}`}>
          {toast.msg}<button onClick={()=>setToast(null)}>×</button>
        </div>
      )}

      {/* Header */}
      <div style={{display:'flex',alignItems:'center',gap:12,marginBottom:16}}>
        <button className={s.btnSm} onClick={onBack}>← Back</button>
        <h2 style={{fontSize:17,fontWeight:700,color:'#2E3D4D',flex:1}}>{reg.companyName}</h2>
        <span className={reg.packageType==='PRO'?s.pkgPro:s.pkgLite}>Xact {reg.packageType==='PRO'?'Pro':'Lite'}</span>
        <StatusPill status={reg.status}/>
        {reg.status === 'DRAFT' && (
          <button className={s.btnG} disabled={busy} onClick={handleSubmit}>Submit for approval</button>
        )}
      </div>

      {/* Decline reason */}
      {reg.declineReason && (
        <div className={s.declineReason}>
          <strong>Declined:</strong> {reg.declineReason}
        </div>
      )}

      {/* Conversion job result */}
      {job && (
        <div className={job.status==='COMPLETE'?s.implyOk:s.info} style={{marginBottom:12}}>
          <strong>Conversion {job.status.toLowerCase()}:</strong> {job.logOutput}
          {job.completedAt && ` — Completed ${fmt(job.completedAt)}`}
        </div>
      )}

      {/* Package summary */}
      <div className={s.card}>
        <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Package & company summary</span></div>
        <div className={s.cb}>
          <div className={s.detailGrid}>
            <div className={s.df}><label>Package</label><span>Xact {reg.packageType==='PRO'?'Pro':'Lite'}</span></div>
            <div className={s.df}><label>Users</label><span>{reg.numUsers}</span></div>
            <div className={s.df}><label>Company type</label><span>{reg.standalone?'Standalone':'Linked to master'}</span></div>
            <div className={s.df}><label>Reg number</label><span>{reg.regNumber||'—'}</span></div>
            <div className={s.df}><label>VAT number</label><span>{reg.vatNumber||'—'}</span></div>
            <div className={s.df}><label>Email</label><span>{reg.companyEmail||'—'}</span></div>
            <div className={s.df}><label>Telephone</label><span>{reg.telephone||'—'}</span></div>
            <div className={s.df}><label>Currency</label><span>{reg.currencyCode||'—'}</span></div>
            <div className={s.df}><label>Year end</label><span>
              {reg.yearEndMonth ? ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][reg.yearEndMonth-1] : '—'}
            </span></div>
            <div className={s.df}><label>Bank name</label><span>{reg.bankName||'—'}</span></div>
            <div className={s.df}><label>Branch code</label><span>{reg.bankBranchCode||'—'}</span></div>
            <div className={s.df}><label>Account number</label><span>{reg.bankAccount||'—'}</span></div>
          </div>
        </div>
      </div>

      {/* Periods */}
      <div className={s.card}>
        <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Periods</span></div>
        <div className={s.cb}>
          <div className={s.detailGrid}>
            {[['GL',reg.periodGl],['CB',reg.periodCb],['DL',reg.periodDl],['SA',reg.periodSa],['CL',reg.periodCl],['PU',reg.periodPu]].map(([lbl,val])=>(
              <div key={lbl} className={s.df}><label>{lbl}</label><span>{val||'—'}</span></div>
            ))}
            <div className={s.df}><label>System year end</label><span>{reg.systemYearEnd||'—'}</span></div>
          </div>
        </div>
      </div>

      {/* Locations */}
      {reg.locations?.length > 0 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Locations ({reg.locations.length})</span></div>
          <table className={s.tbl}>
            <thead><tr><th>Loc</th><th>Whs</th><th>Name</th><th>Region</th><th>Stock loc</th><th>Physical address</th></tr></thead>
            <tbody>{reg.locations.map((l,i)=>(
              <tr key={i}>
                <td>{l.loc}</td><td>{l.whs}</td><td>{l.locName}</td>
                <td>{l.region||'—'}</td><td>{l.stockLoc?'Yes':'No'}</td>
                <td>{l.physicalAddr1||'—'}</td>
              </tr>
            ))}</tbody>
          </table>
        </div>
      )}

      {/* Users */}
      {reg.users?.length > 0 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Base users ({reg.users.length})</span></div>
          <table className={s.tbl}>
            <thead><tr><th>Username</th><th>Full name</th><th>Email</th><th>Default loc</th><th>Access group</th></tr></thead>
            <tbody>{reg.users.map((u,i)=>(
              <tr key={i}>
                <td style={{fontWeight:700,color:'#2E3D4D'}}>{u.username}</td>
                <td>{u.fullName}</td><td>{u.email}</td><td>{u.defaultLoc}</td><td>{u.accessGrp}</td>
              </tr>
            ))}</tbody>
          </table>
        </div>
      )}

      {/* Workflow timeline */}
      {reg.events?.length > 0 && (
        <div className={s.card}>
          <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>Workflow history</span></div>
          <div className={s.cb}>
            <div className={s.tl}>
              {reg.events.map((ev, i) => (
                <div key={i} className={s.tle}>
                  <div className={s.tln} style={{background:EVENT_COLORS[ev.eventType]||'#546E7A'}}>{i+1}</div>
                  <div style={{flex:1}}>
                    <div className={s.tla}>{ev.actorName}</div>
                    <div className={s.tlt}>{EVENT_LABELS[ev.eventType]||ev.eventType}</div>
                    {ev.comments && <div className={s.tlt} style={{color:'#546E7A',fontStyle:'italic'}}>"{ev.comments}"</div>}
                    <div className={s.tlts}>{fmt(ev.createdAt)}</div>
                  </div>
                  <StatusPill status={ev.toStatus}/>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
