import React, { useState, useEffect } from 'react'
import { ChevronLeft, ChevronRight } from 'lucide-react'
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

const PAGE_SIZE = 10

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', { day:'numeric', month:'short', year:'numeric' })
}

export default function AdminDashboard({ onViewReg }) {
  const [regs,   setRegs]   = useState([])
  const [filter, setFilter] = useState('ALL')
  const [page,   setPage]   = useState(0)
  const [err,    setErr]    = useState(null)

  useEffect(() => {
    getAllRegistrations()
      .then(data => { setRegs(data); setPage(0) })
      .catch(() => setErr('Failed to load registrations'))
  }, [])

  const filtered   = filter === 'ALL' ? regs : regs.filter(r => r.status === filter)
  const totalPages = Math.ceil(filtered.length / PAGE_SIZE)
  const paged      = filtered.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE)

  function changeFilter(f) { setFilter(f); setPage(0) }

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}</div>}

      <div className={s.filterTabs}>
        {FILTERS.map(f => {
          const count = f.id==='ALL' ? regs.length : regs.filter(r => r.status===f.id).length
          return (
            <button key={f.id}
              className={`${s.filterTab} ${filter===f.id ? s.filterTabActive : ''}`}
              onClick={() => changeFilter(f.id)}>
              {f.label}{count > 0 && <span style={{opacity:.65, marginLeft:4}}>({count})</span>}
            </button>
          )
        })}
      </div>

      {paged.length === 0
        ? (
          <div className={s.queueEmpty}>
            <div className={s.queueEmptyIcon}>📋</div>
            <div className={s.queueEmptyTitle}>No registrations</div>
            <div className={s.queueEmptySub}>No registrations match this filter</div>
          </div>
        )
        : (
          <div className={s.adminCard}>
            {paged.map(r => (
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
        )
      }

      {totalPages > 1 && (
        <div className={s.pagination}>
          <button className={s.pgBtn} disabled={page===0} onClick={() => setPage(p => p-1)}>
            <ChevronLeft size={15}/> Prev
          </button>
          <span className={s.pgInfo}>Page {page+1} of {totalPages} · {filtered.length} total</span>
          <button className={s.pgBtn} disabled={page===totalPages-1} onClick={() => setPage(p => p+1)}>
            Next <ChevronRight size={15}/>
          </button>
        </div>
      )}
    </div>
  )
}
