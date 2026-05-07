import React, { useState, useEffect } from 'react'
import { Sparkles, X } from 'lucide-react'
import {
  getAllRegistrations, getPendingXact, getPendingImply,
  approveXact, declineXact, approveImply, declineImply,
  triggerConversion, getRegistration, getAiAnalysis
} from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import RegistrationDetail from './RegistrationDetail.jsx'
import s from './Portal.module.css'

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', {day:'numeric',month:'short',year:'numeric'})
}

export default function ApprovalQueue({ session }) {
  const [regs,       setRegs]       = useState([])
  const [err,        setErr]        = useState(null)
  const [busy,       setBusy]       = useState({})
  const [comments,   setComments]   = useState({})
  const [viewId,     setViewId]     = useState(null)
  const [aiPanel,    setAiPanel]    = useState(null)   // { regId, loading, result, error }

  const role = session?.role

  async function openAiAnalysis(regId) {
    setAiPanel({ regId, loading: true, result: null, error: null })
    try {
      const result = await getAiAnalysis(regId)
      setAiPanel(p => ({ ...p, loading: false, result }))
    } catch (e) {
      const msg = e.response?.data?.message || e.response?.data || e.message || 'AI analysis failed'
      setAiPanel(p => ({ ...p, loading: false, error: String(msg) }))
    }
  }

  function applyAiComment(regId, comment) {
    setComments(c => ({ ...c, [regId]: comment }))
    setAiPanel(null)
  }

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

      {/* AI analysis slide-in panel */}
      {aiPanel && (
        <div className={s.aiOverlay} onClick={() => setAiPanel(null)}>
          <div className={s.aiPanel} onClick={e => e.stopPropagation()}>
            <div className={s.aiHeader}>
              <span className={s.aiTitle}><Sparkles size={16}/> AI Analysis</span>
              <button className={s.aiClose} onClick={() => setAiPanel(null)}><X size={16}/></button>
            </div>
            <div className={s.aiBody}>
              {aiPanel.loading && <p className={s.aiHint}>Analysing registration…</p>}
              {aiPanel.error  && <div className={s.aiError}>{aiPanel.error}</div>}
              {aiPanel.result && (() => {
                const r = aiPanel.result
                const decColor = r.suggestedDecision === 'APPROVE' ? 'var(--color-primary)' : 'var(--color-danger)'
                const riskColor = r.riskLevel === 'LOW' ? 'var(--color-primary)' : r.riskLevel === 'MEDIUM' ? 'var(--color-warning)' : 'var(--color-danger)'
                return (
                  <>
                    <div style={{display:'flex',gap:'8px',marginBottom:'4px'}}>
                      <span style={{padding:'3px 10px',borderRadius:'20px',fontSize:'12px',fontWeight:'800',background:decColor,color:'#fff'}}>
                        {r.suggestedDecision}
                      </span>
                      <span style={{padding:'3px 10px',borderRadius:'20px',fontSize:'12px',fontWeight:'700',background:'var(--color-grey-light)',color:riskColor}}>
                        {r.riskLevel} RISK
                      </span>
                    </div>
                    <p className={s.aiReasoning}>{r.reasoning}</p>
                    {r.keyFactors?.length > 0 && (
                      <ul style={{fontSize:'13px',color:'var(--color-text)',paddingLeft:'18px',margin:'0 0 8px'}}>
                        {r.keyFactors.map((f,i) => <li key={i} style={{marginBottom:'4px'}}>{f}</li>)}
                      </ul>
                    )}
                    {r.draftComment && (
                      <div className={s.aiResult}>
                        <div className={s.aiResultTitle}>Draft comment</div>
                        <p style={{padding:'10px 14px',margin:0,fontSize:'13px',color:'var(--color-text)',fontStyle:'italic'}}>
                          {r.draftComment}
                        </p>
                      </div>
                    )}
                  </>
                )
              })()}
            </div>
            {aiPanel.result?.draftComment && (
              <div className={s.aiFooter}>
                <button className={s.aiDecline} onClick={() => setAiPanel(null)}>Close</button>
                <button className={s.aiApply} onClick={() => applyAiComment(aiPanel.regId, aiPanel.result.draftComment)}>
                  Use draft comment
                </button>
              </div>
            )}
          </div>
        </div>
      )}

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
            <button
              onClick={() => openAiAnalysis(r.id)}
              style={{display:'flex',alignItems:'center',gap:'5px',height:'30px',padding:'0 10px',
                background:'var(--color-primary)',color:'#fff',border:'none',borderRadius:'6px',
                fontSize:'12px',fontWeight:'700',cursor:'pointer',fontFamily:'inherit',flexShrink:0}}>
              <Sparkles size={13}/> AI
            </button>
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
