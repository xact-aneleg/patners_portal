import React, { useState } from 'react'
import { login } from '../api/portalApi.js'
import s from './LoginPage.module.css'
import xactLogo from '../../assets/xact.svg'

const ROLES = [
  { label: 'Partner',  email: 'partner@acme.co.za',  hint: 'Channel partner view' },
  { label: 'XactERP', email: 'admin@xacterp.co.za',  hint: 'Internal approval queue' },
  { label: 'Imply',   email: 'approver@imply.co.za', hint: 'Imply approval queue' },
]

export default function LoginPage({ onLogin }) {
  const [email,    setEmail]    = useState('')
  const [pw,       setPw]       = useState('')
  const [showPw,   setShowPw]   = useState(false)
  const [err,      setErr]      = useState(null)
  const [busy,     setBusy]     = useState(false)
  const [remember, setRemember] = useState(false)

  async function handleLogin(e) {
    e.preventDefault()
    setBusy(true); setErr(null)
    try {
      const data = await login(email, pw)
      onLogin(data)
    } catch (ex) {
      setErr(ex.response?.data?.message || 'Invalid username or password')
    } finally { setBusy(false) }
  }

  function quickLogin(roleEmail) { setEmail(roleEmail); setPw('password123') }

  return (
    <div className={s.root}>
      {/* ── Left green panel ── */}
      <div className={s.left}>
        <div className={s.logo}>
          <img src={xactLogo} alt="XactERP" className={s.logoImg} />
          <div className={s.logoText}>
            <span className={s.logoX}>XACT</span>
            <span className={s.logoE}>ERP</span>
          </div>
        </div>

        <div className={s.headline}>
          <h1>Register. Approve.<br/>Go Live.</h1>
          <p>The XactERP Partner Portal lets channel partners register new companies, track approval workflows, and provision live ERP databases — all in one place.</p>
        </div>

        <div className={s.features}>
          <div className={s.feature}>
            <div className={s.featIcon}>
              <svg viewBox="0 0 24 24" fill="none">
                <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2" stroke="#fbba00" strokeWidth="2" strokeLinecap="round"/>
                <circle cx="9" cy="7" r="4" stroke="#fbba00" strokeWidth="2"/>
                <path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75" stroke="#fbba00" strokeWidth="2" strokeLinecap="round"/>
              </svg>
            </div>
            <div>
              <div className={s.featTitle}>Multi-role approval</div>
              <div className={s.featSub}>Partner → Imply → XactERP workflow</div>
            </div>
          </div>
          <div className={s.feature}>
            <div className={s.featIcon}>
              <svg viewBox="0 0 24 24" fill="none">
                <ellipse cx="12" cy="5" rx="9" ry="3" stroke="#fbba00" strokeWidth="2"/>
                <path d="M21 12c0 1.66-4.03 3-9 3S3 13.66 3 12" stroke="#fbba00" strokeWidth="2"/>
                <path d="M3 5v14c0 1.66 4.03 3 9 3s9-1.34 9-3V5" stroke="#fbba00" strokeWidth="2"/>
              </svg>
            </div>
            <div>
              <div className={s.featTitle}>Automatic provisioning</div>
              <div className={s.featSub}>Full ERP database created on approval</div>
            </div>
          </div>
          <div className={s.feature}>
            <div className={s.featIcon}>
              <svg viewBox="0 0 24 24" fill="none">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" stroke="#fbba00" strokeWidth="2" strokeLinejoin="round"/>
              </svg>
            </div>
            <div>
              <div className={s.featTitle}>Xact Lite &amp; Pro</div>
              <div className={s.featSub}>Flexible packages for any business size</div>
            </div>
          </div>
        </div>

        <div className={s.tagline}>Taking you forward</div>
      </div>

      {/* ── Right white panel ── */}
      <div className={s.right}>
        <div className={s.formWrap}>
          <div className={s.adminBadge}>PARTNER PORTAL</div>
          <h2 className={s.formTitle}>Sign in to your account</h2>

          <form onSubmit={handleLogin} className={s.form}>
            <div className={s.field}>
              <label>User name</label>
              <input type="text" value={email} onChange={e=>setEmail(e.target.value)}
                placeholder="username or email" required autoFocus />
            </div>

            <div className={s.field}>
              <label>Password</label>
              <div className={s.pwWrap}>
                <input type={showPw?'text':'password'} value={pw}
                  onChange={e=>setPw(e.target.value)} placeholder="••••••••" required />
                <button type="button" className={s.eyeBtn} onClick={()=>setShowPw(v=>!v)}>
                  {showPw
                    ? <svg viewBox="0 0 24 24" fill="none"><path d="M17.94 17.94A10 10 0 012.06 12C3.17 7.16 7.22 4 12 4c4.78 0 8.83 3.16 9.94 8a10 10 0 01-3.35 6.23M10 10a2 2 0 104 4M3 3l18 18" stroke="#9ba8b3" strokeWidth="1.8" strokeLinecap="round"/></svg>
                    : <svg viewBox="0 0 24 24" fill="none"><path d="M2.06 12C3.17 7.16 7.22 4 12 4c4.78 0 8.83 3.16 9.94 8-1.11 4.84-5.16 8-9.94 8-4.78 0-8.83-3.16-9.94-8z" stroke="#9ba8b3" strokeWidth="1.8"/><circle cx="12" cy="12" r="3" stroke="#9ba8b3" strokeWidth="1.8"/></svg>
                  }
                </button>
              </div>
            </div>

            <div className={s.formRow}>
              <label className={s.checkLabel}>
                <input type="checkbox" checked={remember} onChange={e=>setRemember(e.target.checked)}/>
                <span>Keep me signed in on this device</span>
              </label>
              <button type="button" className={s.forgotBtn}>Forgot password?</button>
            </div>

            {err && <div className={s.err}>{err}</div>}

            <button type="submit" className={s.submitBtn} disabled={busy}>
              {busy ? 'Signing in…' : 'Sign in'}
            </button>
          </form>

          <button type="button" className={s.helpBtn}>Need help?</button>

          <div className={s.demo}>
            <div className={s.demoTitle}>QUICK LOGIN (DEMO)</div>
            <div className={s.demoGrid}>
              {ROLES.map(r => (
                <button key={r.email} className={s.demoBtn} onClick={()=>quickLogin(r.email)}>
                  <div className={s.demoBtnLabel}>{r.label}</div>
                  <div className={s.demoBtnHint}>{r.hint}</div>
                </button>
              ))}
            </div>
            <div className={s.demoNote}>Password: <code>password123</code></div>
          </div>
        </div>
      </div>
    </div>
  )
}
