import React, { useState, useEffect } from 'react'
import {
  getPendingXact, getPendingImply, getRegistration,
  approveXact, declineXact, approveImply, declineImply
} from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

const EVENT_COLORS = {
  SUBMITTED:         '#39B54A',
  APPROVED_IMPLY:    '#39B54A',
  DECLINED_IMPLY:    '#C62828',
  APPROVED_XACT:     '#39B54A',
  DECLINED_XACT:     '#C62828',
  CONVERSION_STARTED:'#1565C0',
  LIVE:              '#39B54A',
}

const EVENT_LABELS = {
  SUBMITTED:          'Registration submitted',
  APPROVED_IMPLY:     'Approved by Imply',
  DECLINED_IMPLY:     'Declined by Imply',
  APPROVED_XACT:      'Approved by XactERP',
  DECLINED_XACT:      'Declined by XactERP',
  CONVERSION_STARTED: 'Data conversion started',
  LIVE:               'Company is now live',
}

function fmt(dt) {
  if (!dt) return '—'
  return new Date(dt).toLocaleString('en-ZA', { dateStyle:'medium', timeStyle:'short' })
}

function RegistrationCard({ reg, role, onDecision }) {
  const [comment, setComment] = useState('')
  const [busy, setBusy]       = useState(false)
  const [expanded, setExpanded] = useState(false)

  async function decide(action) {
    if ((action === 'decline-imply' || action === 'decline-xact') && !comment.trim()) {
      alert('Please enter a reason before declining.'); return
    }
    setBusy(true)
    try {
      if (action === 'approve-imply') await approveImply(reg.id, comment)
      if (action === 'decline-imply') await declineImply(reg.id, comment)
      if (action === 'approve-xact')  await approveXact(reg.id, comment)
      if (action === 'decline-xact')  await declineXact(reg.id, comment)
      onDecision()
    } catch(e) { alert(e.response?.data?.message || 'Action failed') }
    finally { setBusy(false) }
  }

  const impliedApproval = reg.events?.find(e => e.eventType === 'APPROVED_IMPLY')

  return (
    <div className={s.card} style={{marginBottom:12}}>
      {/* Header */}
      <div className={s.ch}>
        <span className={s.cdot}/>
        <span style={{fontSize:14,fontWeight:700,color:'#2E3D4D',flex:1}}>{reg.companyName}</span>
        <span className={reg.packageType==='PRO'?s.pkgPro:s.pkgLite}>Xact {reg.packageType==='PRO'?'Pro':'Lite'}</span>
        <StatusPill status={reg.status}/>
      </div>
      <div style={{padding:'8px 15px 4px',fontSize:11,color:'#546E7A'}}>
        Submitted by {reg.partnerName} · {fmt(reg.submittedAt)}
      </div>

      {/* Company detail grid */}
      <div className={s.cb}>
        <div className={s.detailGrid}>
          <div className={s.df}><label>Reg number</label><span>{reg.regNumber||'—'}</span></div>
          <div className={s.df}><label>VAT number</label><span>{reg.vatNumber||'—'}</span></div>
          <div className={s.df}><label>Users</label><span>{reg.numUsers}</span></div>
          <div className={s.df}><label>Email</label><span>{reg.companyEmail||'—'}</span></div>
          <div className={s.df}><label>Telephone</label><span>{reg.telephone||'—'}</span></div>
          <div className={s.df}><label>Currency</label><span>{reg.currencyCode||'—'}</span></div>
          <div className={s.df}><label>Year end</label><span>{reg.yearEndMonth ? ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][reg.yearEndMonth-1] : '—'}</span></div>
          <div className={s.df}><label>Bank</label><span>{reg.bankName||'—'} {reg.bankBranchCode?`· ${reg.bankBranchCode}`:''}</span></div>
          <div className={s.df}><label>Bank account</label><span>{reg.bankAccount||'—'}</span></div>
        </div>

        {/* Locations */}
        {reg.locations?.length > 0 && (
          <div className={s.section}>
            <div className={s.sectionTitle}>Locations ({reg.locations.length})</div>
            <table className={s.tbl} style={{fontSize:11}}>
              <thead><tr><th>Loc</th><th>Whs</th><th>Name</th><th>Region</th><th>Stock loc</th></tr></thead>
              <tbody>{reg.locations.map((l,i)=>(
                <tr key={i}><td>{l.loc}</td><td>{l.whs}</td><td>{l.locName}</td><td>{l.region||'—'}</td><td>{l.stockLoc?'Yes':'No'}</td></tr>
              ))}</tbody>
            </table>
          </div>
        )}

        {/* Users */}
        {reg.users?.length > 0 && (
          <div className={s.section}>
            <div className={s.sectionTitle}>Base users ({reg.users.length})</div>
            <table className={s.tbl} style={{fontSize:11}}>
              <thead><tr><th>Username</th><th>Full name</th><th>Email</th><th>Default loc</th><th>Access grp</th></tr></thead>
              <tbody>{reg.users.map((u,i)=>(
                <tr key={i}><td>{u.username}</td><td>{u.fullName}</td><td>{u.email}</td><td>{u.defaultLoc}</td><td>{u.accessGrp}</td></tr>
              ))}</tbody>
            </table>
          </div>
        )}

        {/* Imply approval banner (Xact Pro that reached XactERP) */}
        {impliedApproval && (
          <div className={s.implyOk} style={{marginTop:12}}>
            ✓ Imply approved on {fmt(impliedApproval.createdAt)}
            {impliedApproval.comments && ` — "${impliedApproval.comments}"`}
          </div>
        )}

        {/* Workflow history toggle */}
        {reg.events?.length > 0 && (
          <div className={s.section}>
            <div className={s.sectionTitle} style={{cursor:'pointer'}} onClick={()=>setExpanded(v=>!v)}>
              Workflow history ({reg.events.length}) {expanded?'▲':'▼'}
            </div>
            {expanded && (
              <div className={s.tl}>
                {reg.events.map((ev, i) => (
                  <div key={i} className={s.tle}>
                    <div className={s.tln} style={{background:EVENT_COLORS[ev.eventType]||'#546E7A'}}>{i+1}</div>
                    <div>
                      <div className={s.tla}>{ev.actorName}</div>
                      <div className={s.tlt}>{EVENT_LABELS[ev.eventType]||ev.eventType}</div>
                      {ev.comments && <div className={s.tlt} style={{color:'#546E7A',fontStyle:'italic'}}>"{ev.comments}"</div>}
                      <div className={s.tlts}>{fmt(ev.createdAt)}</div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* Approval actions */}
        <div className={s.approvalRow}>
          <input
            value={comment}
            onChange={e => setComment(e.target.value)}
            placeholder={
              role === 'IMPLY'
                ? 'Add comments for XactERP (optional on approval, required on decline)…'
                : 'Add comment (required when declining)…'
            }
          />
          {role === 'IMPLY' && (
            <>
              <button className={s.btnSmG} disabled={busy} onClick={() => decide('approve-imply')}>
                ✓ Approve
              </button>
              <button className={s.btnSmR} disabled={busy} onClick={() => decide('decline-imply')}>
                ✗ Decline
              </button>
            </>
          )}
          {role === 'XACT_ADMIN' && (
            <>
              <button className={s.btnSmG} disabled={busy} onClick={() => decide('approve-xact')}>
                ✓ Approve
              </button>
              <button className={s.btnSmR} disabled={busy} onClick={() => decide('decline-xact')}>
                ✗ Decline
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

export default function ApprovalQueue({ session }) {
  const role = session.role
  const [items,   setItems]   = useState([])
  const [details, setDetails] = useState({})   // id → full RegistrationResponse
  const [loading, setLoading] = useState(true)
  const [toast,   setToast]   = useState(null)

  useEffect(() => { load() }, [])

  async function load() {
    setLoading(true)
    try {
      const list = role === 'IMPLY' ? await getPendingImply() : await getPendingXact()
      setItems(list)
      // Load full details for each item
      const map = {}
      await Promise.all(list.map(async item => {
        map[item.id] = await getRegistration(item.id)
      }))
      setDetails(map)
    } catch(e) {
      setToast({ type:'error', msg:'Failed to load queue' })
    } finally { setLoading(false) }
  }

  return (
    <div>
      {toast && (
        <div className={`${s.toast} ${s['t_'+toast.type]}`}>
          {toast.msg}<button onClick={()=>setToast(null)}>×</button>
        </div>
      )}

      <div className={s.info} style={{marginBottom:14}}>
        {role === 'IMPLY'
          ? 'Showing all Xact Pro registrations pending your first-stage approval. Your decision routes to XactERP for final review.'
          : 'Showing all registrations pending XactERP approval. Xact Lite needs only your sign-off. Xact Pro shown here has already been approved by Imply.'}
      </div>

      {loading ? (
        <div className={s.empty}>Loading…</div>
      ) : items.length === 0 ? (
        <div className={s.empty}>
          No registrations pending your review.
        </div>
      ) : (
        items.map(item => (
          <RegistrationCard
            key={item.id}
            reg={details[item.id] || item}
            role={role}
            onDecision={() => {
              setToast({ type:'success', msg:'Decision recorded. Partner has been notified.' })
              load()
            }}
          />
        ))
      )}
    </div>
  )
}
