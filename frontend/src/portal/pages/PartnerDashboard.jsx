import React, { useState, useEffect } from 'react'
import { listMyRegistrations, submitRegistration } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

const MONTHS = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

export default function PartnerDashboard({ session, onNewReg, onViewReg }) {
  const [regs,    setRegs]    = useState([])
  const [loading, setLoading] = useState(true)
  const [toast,   setToast]   = useState(null)

  useEffect(() => { load() }, [])

  async function load() {
    setLoading(true)
    try { setRegs(await listMyRegistrations()) }
    catch { setToast({ type:'error', msg:'Failed to load registrations' }) }
    finally { setLoading(false) }
  }

  async function handleSubmit(id) {
    try {
      await submitRegistration(id)
      setToast({ type:'success', msg:'Registration submitted for approval.' })
      load()
    } catch(e) { setToast({ type:'error', msg: e.response?.data?.message || 'Submit failed' }) }
  }

  const total    = regs.length
  const pending  = regs.filter(r => r.status.startsWith('PENDING')).length
  const live     = regs.filter(r => r.status === 'LIVE').length
  const converting = regs.filter(r => r.status === 'CONVERTING').length

  return (
    <div>
      {toast && <div className={`${s.toast} ${s['t_'+toast.type]}`}>
        {toast.msg} <button onClick={() => setToast(null)}>×</button></div>}

      <div className={s.stats}>
        <div className={s.stat} style={{borderTopColor:'#39B54A'}}>
          <div className={s.sn} style={{color:'#27500A'}}>{total}</div>
          <div className={s.sl}>Total registrations</div>
        </div>
        <div className={s.stat} style={{borderTopColor:'#EF9F27'}}>
          <div className={s.sn} style={{color:'#633806'}}>{pending}</div>
          <div className={s.sl}>Pending approval</div>
        </div>
        <div className={s.stat} style={{borderTopColor:'#378ADD'}}>
          <div className={s.sn} style={{color:'#0C447C'}}>{converting}</div>
          <div className={s.sl}>In conversion</div>
        </div>
        <div className={s.stat} style={{borderTopColor:'#39B54A'}}>
          <div className={s.sn} style={{color:'#27500A'}}>{live}</div>
          <div className={s.sl}>Live</div>
        </div>
      </div>

      <div className={s.card}>
        <div className={s.ch}>
          <span className={s.cdot} /><span className={s.ct}>My registrations</span>
          <div className={s.ca}><button className={s.btnG} onClick={onNewReg}>+ New registration</button></div>
        </div>
        {loading ? <div className={s.empty}>Loading…</div> : regs.length === 0 ? (
          <div className={s.empty}>No registrations yet. <button className={s.link} onClick={onNewReg}>Create your first one →</button></div>
        ) : (
          <table className={s.tbl}>
            <thead><tr><th>Company</th><th>Package</th><th>Users</th><th>Submitted</th><th>Status</th><th></th></tr></thead>
            <tbody>
              {regs.map(r => (
                <tr key={r.id}>
                  <td className={s.company}>{r.companyName}</td>
                  <td><span className={r.packageType==='PRO' ? s.pkgPro : s.pkgLite}>{r.packageType}</span></td>
                  <td>{r.numUsers}</td>
                  <td>{r.submittedAt ? new Date(r.submittedAt).toLocaleDateString('en-ZA') : '—'}</td>
                  <td><StatusPill status={r.status} /></td>
                  <td className={s.actions}>
                    <button className={s.btnSm} onClick={() => onViewReg(r.id)}>View</button>
                    {r.status === 'DRAFT' && (
                      <button className={s.btnSmG} onClick={() => handleSubmit(r.id)}>Submit</button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  )
}
