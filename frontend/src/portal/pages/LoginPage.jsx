import React, { useState } from 'react'
import { login } from '../api/portalApi.js'
import s from './LoginPage.module.css'

export default function LoginPage({ onLogin }) {
  const [tab,   setTab]   = useState('login')   // 'login'
  const [email, setEmail] = useState('')
  const [pw,    setPw]    = useState('')
  const [err,   setErr]   = useState(null)
  const [busy,  setBusy]  = useState(false)

  const roles = [
    { label: 'Partner',     email: 'partner@acme.co.za',  hint: 'Channel partner view' },
    { label: 'XactERP',    email: 'admin@xacterp.co.za', hint: 'Internal approval queue' },
    { label: 'Imply',      email: 'approver@imply.co.za', hint: 'Imply approval queue' },
  ]

  async function handleLogin(e) {
    e.preventDefault()
    setBusy(true); setErr(null)
    try {
      const data = await login(email, pw)
      onLogin(data)
    } catch (ex) {
      setErr(ex.response?.data?.message || 'Invalid email or password')
    } finally { setBusy(false) }
  }

  function quickLogin(roleEmail) {
    setEmail(roleEmail); setPw('password123')
  }

  return (
    <div className={s.wrap}>
      <div className={s.card}>
        {/* Logo */}
        <div className={s.logo}>
          <span className={s.logoX}>XACT</span>
          <span className={s.logoE}>ERP</span>
        </div>
        <div className={s.subtitle}>Partner Portal</div>
        <div className={s.tagline}>Taking you forward</div>

        <form onSubmit={handleLogin} className={s.form}>
          <div className={s.field}>
            <label>Email address</label>
            <input type="email" value={email} onChange={e => setEmail(e.target.value)}
              placeholder="your@email.com" required autoFocus />
          </div>
          <div className={s.field}>
            <label>Password</label>
            <input type="password" value={pw} onChange={e => setPw(e.target.value)}
              placeholder="••••••••" required />
          </div>
          {err && <div className={s.err}>{err}</div>}
          <button type="submit" className={s.btn} disabled={busy}>
            {busy ? 'Signing in…' : 'Sign in'}
          </button>
        </form>

        <div className={s.quickTitle}>Quick login (demo)</div>
        <div className={s.quickGrid}>
          {roles.map(r => (
            <button key={r.email} className={s.quick} onClick={() => quickLogin(r.email)}>
              <div className={s.quickLabel}>{r.label}</div>
              <div className={s.quickHint}>{r.hint}</div>
            </button>
          ))}
        </div>
        <div className={s.note}>Password for all demo accounts: <code>password123</code></div>
      </div>
    </div>
  )
}
