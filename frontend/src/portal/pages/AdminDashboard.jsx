import React, { useState, useEffect } from 'react'
import { getAllRegistrations } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

function fmt(dt) {
  if (!dt) return '—'
  return new Date(dt).toLocaleDateString('en-ZA')
}

export default function AdminDashboard({ onViewReg }) {
  const [regs,    setRegs]    = useState([])
  const [filter,  setFilter]  = useState('ALL')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    getAllRegistrations().then(setRegs).finally(() => setLoading(false))
  }, [])

  const STATUSES = ['ALL','DRAFT','PENDING_IMPLY','PENDING_XACT','APPROVED','DECLINED_IMPLY','DECLINED_XACT','CONVERTING','LIVE']
  const LABELS   = { ALL:'All', DRAFT:'Draft', PENDING_IMPLY:'Pending Imply',
    PENDING_XACT:'Pending XactERP', APPROVED:'Approved', DECLINED_IMPLY:'Declined (Imply)',
    DECLINED_XACT:'Declined (XactERP)', CONVERTING:'Converting', LIVE:'Live' }

  const shown = filter === 'ALL' ? regs : regs.filter(r => r.status === filter)

  const counts = {}
  STATUSES.forEach(st => { counts[st] = st === 'ALL' ? regs.length : regs.filter(r=>r.status===st).length })

  return (
    <div>
      {/* Stat row */}
      <div style={{display:'grid',gridTemplateColumns:'repeat(4,1fr)',gap:10,marginBottom:16}}>
        {[
          { label:'Total',       value:counts.ALL,          color:'#39B54A', text:'#27500A' },
          { label:'Pending',     value:counts.PENDING_XACT + counts.PENDING_IMPLY, color:'#EF9F27', text:'#633806' },
          { label:'Converting',  value:counts.CONVERTING,   color:'#378ADD', text:'#0C447C' },
          { label:'Live',        value:counts.LIVE,         color:'#39B54A', text:'#27500A' },
        ].map(st => (
          <div key={st.label} className={s.stat} style={{borderTopColor:st.color}}>
            <div className={s.sn} style={{color:st.text}}>{st.value}</div>
            <div className={s.sl}>{st.label}</div>
          </div>
        ))}
      </div>

      {/* Filter tabs */}
      <div style={{display:'flex',gap:4,flexWrap:'wrap',marginBottom:12}}>
        {STATUSES.map(st => (
          <button key={st}
            onClick={() => setFilter(st)}
            style={{
              padding:'4px 10px', borderRadius:3, fontSize:11, fontWeight:600, cursor:'pointer',
              border:'1px solid', fontFamily:'inherit',
              background: filter===st ? '#2E3D4D' : '#EEF1F4',
              color:       filter===st ? '#fff'    : '#546E7A',
              borderColor: filter===st ? '#2E3D4D' : '#C8D4DC',
            }}
          >
            {LABELS[st]} {counts[st] > 0 && <span style={{opacity:.7}}>({counts[st]})</span>}
          </button>
        ))}
      </div>

      {/* Table */}
      <div className={s.card}>
        <div className={s.ch}><span className={s.cdot}/><span className={s.ct}>All registrations</span></div>
        {loading ? <div className={s.empty}>Loading…</div> : shown.length === 0 ? (
          <div className={s.empty}>No registrations match this filter.</div>
        ) : (
          <table className={s.tbl}>
            <thead><tr><th>Company</th><th>Package</th><th>Users</th><th>Partner</th><th>Submitted</th><th>Status</th><th></th></tr></thead>
            <tbody>
              {shown.map(r => (
                <tr key={r.id}>
                  <td className={s.company}>{r.companyName}</td>
                  <td><span className={r.packageType==='PRO'?s.pkgPro:s.pkgLite}>Xact {r.packageType==='PRO'?'Pro':'Lite'}</span></td>
                  <td>{r.numUsers}</td>
                  <td>{r.partnerName}</td>
                  <td>{fmt(r.submittedAt)}</td>
                  <td><StatusPill status={r.status}/></td>
                  <td><button className={s.btnSm} onClick={() => onViewReg(r.id)}>View</button></td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  )
}
