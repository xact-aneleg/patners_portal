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
  { id:'DRAFT',         label:'Draft' },
  { id:'DECLINED_XACT', label:'Declined' },
]

// Display order for status groups — most urgent first
const STATUS_ORDER = [
  'PENDING_IMPLY', 'PENDING_XACT', 'CONVERTING',
  'LIVE', 'DRAFT', 'DECLINED_XACT', 'DECLINED_IMPLY',
]

const STATUS_LABELS = {
  PENDING_IMPLY:  'Pending Imply',
  PENDING_XACT:   'Pending XactERP',
  CONVERTING:     'Converting',
  LIVE:           'Live',
  DRAFT:          'Draft',
  DECLINED_XACT:  'Declined by XactERP',
  DECLINED_IMPLY: 'Declined by Imply',
}

const STATUS_ACCENT = {
  PENDING_IMPLY:  '#ff8c00',
  PENDING_XACT:   '#fbba00',
  CONVERTING:     '#0077cc',
  LIVE:           '#3aaa35',
  DRAFT:          '#6b7c8d',
  DECLINED_XACT:  '#dc3545',
  DECLINED_IMPLY: '#dc3545',
}

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', { day:'numeric', month:'short', year:'numeric' })
}

function RegCard({ r, onViewReg }) {
  return (
    <div className={s.regCard} onClick={() => onViewReg(r.id)}>
      <div className={s.regCardTop}>
        <span className={s.regCardPkg}>{r.packageType}</span>
        <span className={s.regCardDate}>{fmt(r.submittedAt || r.createdAt)}</span>
      </div>
      <div className={s.regCardName}>{r.companyName}</div>
      <div className={s.regCardPartner}>{r.partnerName || '—'}</div>
      <div className={s.regCardFoot}>
        <StatusPill status={r.status}/>
      </div>
    </div>
  )
}

export default function AdminDashboard({ onViewReg }) {
  const [regs,   setRegs]   = useState([])
  const [filter, setFilter] = useState('ALL')
  const [err,    setErr]    = useState(null)

  useEffect(() => {
    getAllRegistrations()
      .then(data => setRegs(data))
      .catch(() => setErr('Failed to load registrations'))
  }, [])

  const filtered = filter === 'ALL' ? regs : regs.filter(r => r.status === filter)

  const groups = STATUS_ORDER
    .map(status => ({ status, items: filtered.filter(r => r.status === status) }))
    .filter(g => g.items.length > 0)

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}</div>}

      <div className={s.filterTabs}>
        {FILTERS.map(f => {
          const count = f.id === 'ALL' ? regs.length : regs.filter(r => r.status === f.id).length
          return (
            <button key={f.id}
              className={`${s.filterTab} ${filter === f.id ? s.filterTabActive : ''}`}
              onClick={() => setFilter(f.id)}>
              {f.label}
              {count > 0 && <span className={s.filterTabCount}>{count}</span>}
            </button>
          )
        })}
      </div>

      {filtered.length === 0 ? (
        <div className={s.queueEmpty}>
          <div className={s.queueEmptyIcon}>📋</div>
          <div className={s.queueEmptyTitle}>No registrations</div>
          <div className={s.queueEmptySub}>No registrations match this filter</div>
        </div>
      ) : filter === 'ALL' ? (
        // Grouped view
        <div className={s.adminGroups}>
          {groups.map(g => (
            <div key={g.status} className={s.adminGroup}>
              <div className={s.adminGroupHeader}
                style={{ borderLeftColor: STATUS_ACCENT[g.status] }}>
                <span className={s.adminGroupLabel}>{STATUS_LABELS[g.status]}</span>
                <span className={s.adminGroupCount}>{g.items.length}</span>
              </div>
              <div className={s.regCardGrid}>
                {g.items.map(r => (
                  <RegCard key={r.id} r={r} onViewReg={onViewReg}/>
                ))}
              </div>
            </div>
          ))}
        </div>
      ) : (
        // Flat grid for a specific status filter
        <div className={s.regCardGrid}>
          {filtered.map(r => (
            <RegCard key={r.id} r={r} onViewReg={onViewReg}/>
          ))}
        </div>
      )}
    </div>
  )
}
