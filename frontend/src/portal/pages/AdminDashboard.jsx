import React, { useState, useEffect } from 'react'
import { getAllRegistrations } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Portal.module.css'

const FILTERS = [
  { id:'ALL',           label:'All' },
  { id:'PENDING_XACT',  label:'Pending XactERP' },
  { id:'PENDING_IMPLY', label:'Pending Imply' },
  { id:'CONVERTING',    label:'Converting' },
  { id:'LIVE',          label:'Live' },
  { id:'DECLINED_XACT', label:'Declined' },
]

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', {day:'numeric',month:'short',year:'numeric'})
}

export default function AdminDashboard({ onViewReg }) {
  const [regs,   setRegs]   = useState([])
  const [filter, setFilter] = useState('ALL')
  const [err,    setErr]    = useState(null)

  useEffect(() => {
    getAllRegistrations()
      .then(setRegs)
      .catch(() => setErr('Failed to load registrations'))
  }, [])

  const filtered = filter === 'ALL' ? regs : regs.filter(r => r.status === filter)

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}</div>}

      {/* Filter tabs */}
      <div className={s.filterTabs}>
        {FILTERS.map(f => {
          const count = f.id==='ALL' ? regs.length : regs.filter(r=>r.status===f.id).length
          return (
            <button key={f.id}
              className={`${s.filterTab} ${filter===f.id ? s.filterTabActive : ''}`}
              onClick={() => setFilter(f.id)}>
              {f.label} {count > 0 && <span style={{opacity:.7, marginLeft:4}}>({count})</span>}
            </button>
          )
        })}
      </div>

      {/* Registration list */}
      {filtered.length === 0
        ? <div className={s.queueEmpty}>
            <div className={s.queueEmptyIcon}>📋</div>
            <div className={s.queueEmptyTitle}>No registrations</div>
            <div className={s.queueEmptySub}>No registrations match this filter</div>
          </div>
        : <div className={s.adminCard}>
            {filtered.map(r => (
              <div key={r.id} className={s.adminCardRow} onClick={() => onViewReg(r.id)}>
                <div className={s.adminRowMain}>
                  <div className={s.adminRowCompany}>{r.companyName}</div>
                  <div className={s.adminRowMeta}>
                    <span className={s.adminRowPkg}>{r.packageType}</span>
                    <StatusPill status={r.status}/>
                    {r.partnerName && <span className={s.adminRowPartner}>· {r.partnerName}</span>}
                  </div>
                </div>
                <div className={s.adminRowRight}>
                  <span className={s.adminRowDate}>{fmt(r.submittedAt || r.createdAt)}</span>
                  <span className={s.adminRowChevron}>›</span>
                </div>
              </div>
            ))}
          </div>
      }
    </div>
  )
}
