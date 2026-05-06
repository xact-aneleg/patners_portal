import React, { useState, useEffect } from 'react'
import {
  getAllRegistrations, getPendingXact, getPendingImply,
  approveXact, declineXact, approveImply, declineImply,
  triggerConversion, getRegistration
} from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import RegistrationDetail from './RegistrationDetail.jsx'
import s from './Portal.module.css'

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', {day:'numeric',month:'short',year:'numeric'})
}

export default function ApprovalQueue({ session }) {
  const [regs,      setRegs]      = useState([])
  const [err,       setErr]       = useState(null)
  const [busy,      setBusy]      = useState({})
  const [comments,  setComments]  = useState({})
  const [viewId,    setViewId]    = useState(null)

  const role = session?.role

  useEffect(() => {
    const fn = role==='IMPLY' ? getPendingImply
             : role==='XACT_ADMIN' ? getPendingXact
             : getAllRegistrations
    fn().then(setRegs).catch(() => setErr('Failed to load queue'))
  }, [role])

  if (viewId) return <RegistrationDetail regId={viewId} onBack={() => setViewId(null)}/>

  async function act(id, action) {
    setBusy(b => ({...b,[id]:true}))
    try {
      const c = comments[id] || ''
      let updated
      if      (action==='approve-xact')  updated = await approveXact(id, c)
      else if (action==='decline-xact')  updated = await declineXact(id, c)
      else if (action==='approve-imply') updated = await approveImply(id, c)
      else if (action==='decline-imply') updated = await declineImply(id, c)
      else if (action==='convert')       updated = await triggerConversion(id)
      setRegs(prev => prev.filter(r => r.id !== id))
    } catch (e) {
      setErr(e.response?.data?.message || 'Action failed')
    } finally { setBusy(b => ({...b,[id]:false})) }
  }

  if (regs.length === 0 && !err) return (
    <div className={s.queueEmpty}>
      <div className={s.queueEmptyIcon}>✓</div>
      <div className={s.queueEmptyTitle}>Queue is clear</div>
      <div className={s.queueEmptySub}>No registrations pending review</div>
    </div>
  )

  return (
    <div className={s.page}>
      {err && <div className={s.alertErr}>{err}<button className={s.alertClose} onClick={()=>setErr(null)}>×</button></div>}

      {regs.map(r => (
        <div key={r.id} className={s.queueCard}>
          {/* Card header */}
          <div className={s.queueCardHead}>
            <div style={{flex:1}}>
              <div className={s.queueCompany}>{r.companyName}</div>
              <div className={s.queueMeta}>
                <span className={s.queuePkg}>{r.packageType}</span>
                <StatusPill status={r.status}/>
                {r.partnerName && <span className={s.queuePartner}>via {r.partnerName}</span>}
              </div>
            </div>
          </div>

          {/* Details grid */}
          <div className={s.queueDetails}>
            <div className={s.queueField}>
              <div className={s.queueFieldKey}>Submitted</div>
              <div className={s.queueFieldVal}>{fmt(r.submittedAt)}</div>
            </div>
            <div className={s.queueField}>
              <div className={s.queueFieldKey}>Package</div>
              <div className={s.queueFieldVal}>{r.packageType}</div>
            </div>
            <div className={s.queueField}>
              <div className={s.queueFieldKey}>Users</div>
              <div className={s.queueFieldVal}>{r.numUsers}</div>
            </div>
            <div className={s.queueField}>
              <div className={s.queueFieldKey}>Partner</div>
              <div className={s.queueFieldVal}>{r.partnerName || '—'}</div>
            </div>
          </div>

          {/* Actions */}
          <div className={s.queueActions}>
            <input
              className={s.queueComment}
              placeholder="Optional comment…"
              value={comments[r.id] || ''}
              onChange={e => setComments(c => ({...c,[r.id]:e.target.value}))}
            />
            <div className={s.queueBtnRow}>
              {role === 'XACT_ADMIN' && r.status === 'PENDING_XACT' && (<>
                <button className={s.btnApprove} onClick={()=>act(r.id,'approve-xact')} disabled={busy[r.id]}>
                  {busy[r.id] ? '…' : '✓ Approve'}
                </button>
                <button className={s.btnDecline} onClick={()=>act(r.id,'decline-xact')} disabled={busy[r.id]}>
                  ✕ Decline
                </button>
              </>)}
              {role === 'IMPLY' && r.status === 'PENDING_IMPLY' && (<>
                <button className={s.btnApprove} onClick={()=>act(r.id,'approve-imply')} disabled={busy[r.id]}>
                  {busy[r.id] ? '…' : '✓ Approve'}
                </button>
                <button className={s.btnDecline} onClick={()=>act(r.id,'decline-imply')} disabled={busy[r.id]}>
                  ✕ Decline
                </button>
              </>)}
              {role === 'XACT_ADMIN' && r.status === 'APPROVED' && (
                <button className={s.btnTrigger} onClick={()=>act(r.id,'convert')} disabled={busy[r.id]}>
                  ⚡ Trigger conversion
                </button>
              )}
            </div>
            <button className={s.btnViewDetail} onClick={()=>setViewId(r.id)}>
              View full details →
            </button>
          </div>
        </div>
      ))}
    </div>
  )
}
