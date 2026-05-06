import React, { useState, useEffect } from 'react'
import { getRegistration } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Portal.module.css'

const TIMELINE_COLORS = {
  SUBMITTED:          '#fbba00',
  APPROVED_IMPLY:     '#3aaa35',
  DECLINED_IMPLY:     '#dc3545',
  APPROVED_XACT:      '#3aaa35',
  DECLINED_XACT:      '#dc3545',
  CONVERSION_STARTED: '#1565c0',
  LIVE:               '#3aaa35',
  default:            '#475a68',
}

function fmt(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('en-ZA', {
    day:'numeric', month:'short', year:'numeric',
    hour:'2-digit', minute:'2-digit'
  })
}

function KV({ label, value }) {
  if (!value && value !== 0) return null
  return (
    <div className={s.kvRow}>
      <div className={s.kvKey}>{label}</div>
      <div className={s.kvVal}>{value}</div>
    </div>
  )
}

export default function RegistrationDetail({ regId, onBack }) {
  const [reg, setReg] = useState(null)
  const [err, setErr] = useState(null)

  useEffect(() => {
    getRegistration(regId)
      .then(setReg)
      .catch(() => setErr('Failed to load registration'))
  }, [regId])

  if (err)  return <div className={s.alertErr}>{err}</div>
  if (!reg) return <div style={{padding:24,textAlign:'center',color:'#6b7c8d'}}>Loading…</div>

  const events = reg.events || []

  return (
    <div className={s.page}>
      {/* ── Header ── */}
      <div className={s.detailHeader}>
        <div>
          <div className={s.detailCompany}>{reg.companyName}</div>
          <div className={s.detailMeta}>
            <span className={s.detailPkg}>{reg.packageType}</span>
            <StatusPill status={reg.status}/>
          </div>
        </div>
        <button className={s.btnBackSmall} onClick={onBack}>← Back</button>
      </div>

      {/* ── Conversion log ── */}
      {reg.conversionLog && (
        <div className={s.sectionCard}>
          <div className={s.sectionHead}>Conversion log</div>
          <div style={{padding:14}}>
            <div className={s.logBox}>{reg.conversionLog}</div>
          </div>
        </div>
      )}

      {/* ── Package & company ── */}
      <div className={s.sectionCard}>
        <div className={s.sectionHead}>Package &amp; company summary</div>
        <div className={s.sectionBody}>
          <KV label="Package"      value={reg.packageType}/>
          <KV label="Users"        value={reg.numUsers}/>
          <KV label="Company type" value={reg.standalone ? 'Standalone' : reg.masterOrSlave}/>
          <KV label="Reg number"   value={reg.regNumber}/>
          <KV label="VAT number"   value={reg.vatNumber}/>
          <KV label="Email"        value={reg.companyEmail}/>
          <KV label="Telephone"    value={reg.telephone}/>
          <KV label="Currency"     value={reg.currencyCode}/>
          <KV label="Year end"     value={reg.yearEndMonth ? new Date(0,reg.yearEndMonth-1).toLocaleString('en',{month:'short'}) : null}/>
          <KV label="Bank name"    value={reg.bankName}/>
          <KV label="Branch code"  value={reg.bankBranchCode}/>
          <KV label="Account no."  value={reg.bankAccount}/>
        </div>
      </div>

      {/* ── Postal address ── */}
      {(reg.postalAddr1 || reg.physicalAddr1) && (
        <div className={s.sectionCard}>
          <div className={s.sectionHead}>Address</div>
          <div className={s.sectionBody}>
            {reg.postalAddr1 && <>
              <KV label="Postal 1"  value={reg.postalAddr1}/>
              <KV label="Postal 2"  value={reg.postalAddr2}/>
              <KV label="Postal 3"  value={reg.postalAddr3}/>
              <KV label="Postal 4"  value={reg.postalAddr4}/>
            </>}
            {reg.physicalAddr1 && <>
              <KV label="Physical 1" value={reg.physicalAddr1}/>
              <KV label="Physical 2" value={reg.physicalAddr2}/>
              <KV label="Physical 3" value={reg.physicalAddr3}/>
              <KV label="Physical 4" value={reg.physicalAddr4}/>
            </>}
          </div>
        </div>
      )}

      {/* ── Periods ── */}
      <div className={s.sectionCard}>
        <div className={s.sectionHead}>Current periods</div>
        <div className={s.sectionBody}>
          <div className={s.itemGrid} style={{gap:12, padding:'4px 0'}}>
            {[['GL',reg.periodGl],['CB',reg.periodCb],['DL',reg.periodDl],
              ['SA',reg.periodSa],['CL',reg.periodCl],['PU',reg.periodPu]].map(([k,v])=>(
              <div key={k} className={s.itemField}>
                <div className={s.itemKey}>{k}</div>
                <div className={s.itemVal}>{v ?? '—'}</div>
              </div>
            ))}
          </div>
          <KV label="Year end" value={reg.systemYearEnd}/>
        </div>
      </div>

      {/* ── Locations ── */}
      {reg.locations?.length > 0 && (
        <div className={s.sectionCard}>
          <div className={s.sectionHead}>Locations ({reg.locations.length})</div>
          <div style={{padding:'12px 16px', display:'flex', flexDirection:'column', gap:10}}>
            {reg.locations.map((loc, i) => (
              <div key={i} className={s.itemCard}>
                <div className={s.itemTitle}>
                  <span style={{fontFamily:'monospace', background:'#e8ecf0', padding:'2px 8px', borderRadius:4}}>
                    {loc.loc}/{loc.whs}
                  </span>
                  {' '}{loc.locName}
                </div>
                <div className={s.itemGrid}>
                  <div className={s.itemField}><div className={s.itemKey}>Region</div><div className={s.itemVal}>{loc.region || '—'}</div></div>
                  <div className={s.itemField}><div className={s.itemKey}>Stock loc</div><div className={s.itemVal}>{loc.stockLoc ? 'Yes' : 'No'}</div></div>
                  <div className={s.itemField}><div className={s.itemKey}>Address</div><div className={s.itemVal}>{loc.physicalAddr1 || '—'}</div></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* ── Users ── */}
      {reg.users?.length > 0 && (
        <div className={s.sectionCard}>
          <div className={s.sectionHead}>Base users ({reg.users.length})</div>
          <div style={{padding:'12px 16px', display:'flex', flexDirection:'column', gap:10}}>
            {reg.users.map((u, i) => (
              <div key={i} className={s.itemCard}>
                <div className={s.itemTitle}>
                  <span style={{fontFamily:'monospace', background:'#364553', color:'#fff', padding:'2px 8px', borderRadius:4, fontSize:12}}>
                    {u.username}
                  </span>
                  {' '}{u.fullName}
                </div>
                <div className={s.itemGrid}>
                  <div className={s.itemField}><div className={s.itemKey}>Email</div><div className={s.itemVal}>{u.email || '—'}</div></div>
                  <div className={s.itemField}><div className={s.itemKey}>Default loc</div><div className={s.itemVal}>{u.defaultLoc || '—'}</div></div>
                  <div className={s.itemField}><div className={s.itemKey}>Access group</div><div className={s.itemVal}>{u.accessGrp || '—'}</div></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* ── Workflow timeline ── */}
      {events.length > 0 && (
        <div className={s.sectionCard}>
          <div className={s.sectionHead}>Workflow history</div>
          <div style={{padding:'16px 18px'}}>
            <div className={s.timeline}>
              {events.map((ev, i) => {
                const color = TIMELINE_COLORS[ev.eventType] || TIMELINE_COLORS.default
                const isLast = i === events.length - 1
                return (
                  <div key={ev.id} className={s.timelineItem}>
                    <div className={s.timelineLeft}>
                      <div className={s.timelineDot} style={{background:color}}>
                        {i + 1}
                      </div>
                      {!isLast && <div className={s.timelineLine}/>}
                    </div>
                    <div className={s.timelineContent}>
                      <div className={s.timelineCard}>
                        <div className={s.timelineActor}>{ev.actorName || 'System'}</div>
                        <div className={s.timelineEvent}>
                          {ev.eventType?.replace(/_/g,' ').replace(/\b\w/g,c=>c.toUpperCase())}
                        </div>
                        {ev.comments && (
                          <div className={s.timelineComment}>"{ev.comments}"</div>
                        )}
                        <div className={s.timelineDate}>{fmt(ev.createdAt)}</div>
                        <div className={s.timelineStatus}>
                          <StatusPill status={ev.toStatus}/>
                        </div>
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
