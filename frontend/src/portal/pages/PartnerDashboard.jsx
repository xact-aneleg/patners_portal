import React, { useState, useEffect } from 'react'
import { listMyRegistrations, submitRegistration } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

export default function PartnerDashboard({ session, onNewReg, onViewReg }) {
  const [regs,  setRegs]  = useState([])
  const [err,   setErr]   = useState(null)
  const [busy,  setBusy]  = useState(false)

  useEffect(() => {
    listMyRegistrations()
      .then(setRegs)
      .catch(() => setErr('Failed to load registrations'))
  }, [])

  async function handleSubmit(id) {
    setBusy(true)
    try {
      const updated = await submitRegistration(id)
      setRegs(prev => prev.map(r => r.id === id ? { ...r, status: updated.status } : r))
    } catch (e) {
      setErr('Failed to submit: ' + (e.response?.data?.message || e.message))
    } finally { setBusy(false) }
  }

  const total   = regs.length
  const pending = regs.filter(r => r.status?.includes('PENDING')).length
  const conv    = regs.filter(r => r.status === 'CONVERTING').length
  const live    = regs.filter(r => r.status === 'LIVE').length

  return (
    <div className={s.page}>
      {err && <div className={s.err}>{err}<button onClick={()=>setErr(null)}>×</button></div>}

      {/* Stat cards */}
      <div className={s.statGrid}>
        {[
          { n:total,   l:'Total registrations', color:'#364553' },
          { n:pending, l:'Pending approval',    color:'#fbba00' },
          { n:conv,    l:'In conversion',        color:'#1565c0' },
          { n:live,    l:'Live',                 color:'#3aaa35' },
        ].map((c,i) => (
          <div key={i} className={s.statCard} style={{borderTopColor:c.color}}>
            <div className={s.statNum} style={{color:c.color}}>{c.n}</div>
            <div className={s.statLbl}>{c.l}</div>
          </div>
        ))}
      </div>

      {/* Header row */}
      <div className={s.sectionHeader}>
        <span className={s.sectionTitle}>MY REGISTRATIONS</span>
        <button className={s.btnNew} onClick={onNewReg}>+ New registration</button>
      </div>

      {/* Registration list — cards on mobile, table on desktop */}
      {regs.length === 0
        ? <div className={s.empty}>
            No registrations yet.{' '}
            <button className={s.linkBtn} onClick={onNewReg}>Create your first one →</button>
          </div>
        : <div className={s.regList}>
            {/* Desktop table header — hidden on mobile */}
            <div className={s.tableHeader}>
              <span>Company</span>
              <span>Package</span>
              <span>Status</span>
              <span>Submitted</span>
              <span>Actions</span>
            </div>

            {regs.map(r => (
              <div key={r.id} className={s.regCard}>
                {/* Main info row */}
                <div className={s.regMain}>
                  <div className={s.regName}>{r.companyName}</div>
                  <div className={s.regMeta}>
                    <span className={s.regPkg}>{r.packageType}</span>
                    <StatusPill status={r.status}/>
                  </div>
                </div>

                {/* Date */}
                {r.submittedAt && (
                  <div className={s.regDate}>
                    Submitted: {new Date(r.submittedAt).toLocaleDateString('en-ZA')}
                  </div>
                )}

                {/* Actions */}
                <div className={s.regActions}>
                  <button className={s.btnView} onClick={() => onViewReg(r.id)}>View →</button>
                  {r.status === 'DRAFT' && (
                    <button className={s.btnSubmit} onClick={() => handleSubmit(r.id)} disabled={busy}>
                      Submit
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
      }
    </div>
  )
}
