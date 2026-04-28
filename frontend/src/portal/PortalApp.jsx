import React, { useState, useRef } from 'react'
import { logout, getSession } from './api/portalApi.js'
import LoginPage          from './pages/LoginPage.jsx'
import PartnerDashboard   from './pages/PartnerDashboard.jsx'
import RegistrationForm   from './pages/RegistrationForm.jsx'
import RegistrationDetail from './pages/RegistrationDetail.jsx'
import ApprovalQueue      from './pages/ApprovalQueue.jsx'
import AdminDashboard     from './pages/AdminDashboard.jsx'
import ps from './PortalApp.module.css'
import xactLogo from '../assets/xact.svg'

const NAV = {
  PARTNER:    [{ id:'dashboard', label:'Dashboard',        icon:'⊞' },
               { id:'new-reg',   label:'New registration', icon:'+' }],
  XACT_ADMIN: [{ id:'dashboard', label:'All registrations', icon:'⊞' },
               { id:'queue',     label:'Approval queue',    icon:'✓' }],
  IMPLY:      [{ id:'queue',     label:'Pending review',    icon:'✓' }],
}

const ROLE_LABELS = {
  PARTNER:'Channel Partner', XACT_ADMIN:'XactERP Admin', IMPLY:'Imply Approver'
}

const AVATAR_KEY = 'pp_avatar'

export default function PortalApp() {
  const [session,    setSession]    = useState(() => getSession())
  const [page,       setPage]       = useState('dashboard')
  const [viewId,     setViewId]     = useState(null)
  const [collapsed,  setCollapsed]  = useState(false)
  const [mobileOpen, setMobileOpen] = useState(false)

  // Profile picture — persisted in localStorage so it survives logout
  const [avatarSrc, setAvatarSrc] = useState(
    () => localStorage.getItem(AVATAR_KEY) || null
  )

  if (!session) return <LoginPage onLogin={data => { setSession(data); setPage('dashboard') }} />

  const role = session.role
  const nav  = NAV[role] || []

  function handleLogout() {
    logout()           // clears token/role/name/pid but NOT pp_avatar
    setSession(null)
    setPage('dashboard')
    // avatarSrc state stays — but since session is null we go to login
    // On next login, avatar is reloaded from localStorage via useState initializer
  }

  function handleAvatarChange(e) {
    const file = e.target.files[0]
    if (!file) return
    const reader = new FileReader()
    reader.onload = ev => {
      const dataUrl = ev.target.result
      setAvatarSrc(dataUrl)
      localStorage.setItem(AVATAR_KEY, dataUrl) // persist across sessions
    }
    reader.readAsDataURL(file)
  }

  function goViewReg(id)  { setViewId(id); setPage('view-reg'); setMobileOpen(false) }
  function goNewReg()     { setPage('new-reg'); setMobileOpen(false) }
  function goBack()       { setPage('dashboard') }

  function renderPage() {
    if (page === 'view-reg' && viewId)
      return <RegistrationDetail regId={viewId} onBack={goBack} />
    if (page === 'new-reg' && role === 'PARTNER')
      return <RegistrationForm onBack={goBack} onDone={() => setPage('dashboard')} />
    if (page === 'queue')
      return <ApprovalQueue session={session} />
    if (role === 'PARTNER')    return <PartnerDashboard session={session} onNewReg={goNewReg} onViewReg={goViewReg} />
    if (role === 'XACT_ADMIN') return <AdminDashboard onViewReg={goViewReg} />
    if (role === 'IMPLY')      return <ApprovalQueue session={session} />
    return null
  }

  const PAGE_TITLES = {
    dashboard:  role==='PARTNER'     ? {title:'Partner dashboard',    sub:'Your company registrations'}
              : role==='XACT_ADMIN'  ? {title:'All registrations',    sub:'XactERP admin — all partners'}
              :                        {title:'Imply queue',           sub:'Pending review'},
    'new-reg':  {title:'New company registration', sub:'Step through the registration form'},
    'view-reg': {title:'Registration detail',      sub:'Full registration and workflow history'},
    queue:      role==='IMPLY'
                  ? {title:'Imply approval queue',   sub:'Xact Pro first-stage decisions'}
                  : {title:'XactERP approval queue', sub:'Pending XactERP approval'},
  }
  const pt = PAGE_TITLES[page] || {title:'', sub:''}
  const activePage = page === 'view-reg' ? 'dashboard' : page

  const initials = session.name
    ? session.name.split(' ').filter(Boolean).map(w=>w[0]).join('').substring(0,2).toUpperCase()
    : 'U'
  const displayName = session.name?.split(' — ')[0] || session.name || session.email

  return (
    <div className={ps.root}>
      {/* ── Topbar ── */}
      <header className={ps.topbar}>
        <button className={ps.hamburger} onClick={() => setMobileOpen(v=>!v)}>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
            <line x1="3" y1="6"  x2="21" y2="6"/>
            <line x1="3" y1="12" x2="21" y2="12"/>
            <line x1="3" y1="18" x2="21" y2="18"/>
          </svg>
        </button>
        <div className={ps.brand}>
          <img src={xactLogo} alt="XactERP" className={ps.blogo} />
          <span className={ps.bx}>XACT</span>
          <span className={ps.be}>ERP</span>
          <span className={ps.bmod}>Partner Portal</span>
        </div>
        <div className={ps.tbsp}/>
      </header>

      <div className={ps.layout}>
        {/* Mobile overlay */}
        <div className={`${ps.overlay} ${mobileOpen ? ps.overlayVisible : ''}`}
          onClick={() => setMobileOpen(false)} />

        {/* ── Sidebar ── */}
        <aside className={`${ps.sidebar} ${collapsed ? ps.collapsed : ''} ${mobileOpen ? ps.mobileOpen : ''}`}>

          {/* Jira-style collapse toggle — desktop only */}
          <button className={ps.collapseBtn} onClick={() => setCollapsed(v=>!v)}
            title={collapsed ? 'Expand' : 'Collapse'}>
            {collapsed
              ? <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="9 18 15 12 9 6"/><polyline points="15 18 21 12 15 6"/>
                </svg>
              : <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="15 18 9 12 15 6"/><polyline points="9 18 3 12 9 6"/>
                </svg>
            }
          </button>

          {/* Nav */}
          <div className={ps.sidebarNav}>
            <div className={ps.sbLabel}>
              {role==='PARTNER' ? 'Partner menu' : role==='XACT_ADMIN' ? 'Admin menu' : 'Imply menu'}
            </div>
            {nav.map(n => (
              <button key={n.id}
                className={`${ps.navItem} ${activePage===n.id ? ps.navActive : ''}`}
                data-label={n.label}
                onClick={() => { setViewId(null); setPage(n.id); setMobileOpen(false) }}>
                <span className={ps.navIcon}>{n.icon}</span>
                <span className={ps.navLabel}>{n.label}</span>
              </button>
            ))}
          </div>

          {/* ── Bottom: Sign out + User profile ── */}
          <div className={ps.sidebarBottom}>
            <button className={ps.signOutBtn} onClick={handleLogout} data-label="Sign out">
              <span className={ps.navIcon}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/>
                  <polyline points="16 17 21 12 16 7"/>
                  <line x1="21" y1="12" x2="9" y2="12"/>
                </svg>
              </span>
              <span className={ps.navLabel}>Sign out</span>
            </button>

            <div className={ps.sbDivider}/>

            {/* User card with persistent avatar */}
            <div className={ps.userCard} data-label="Change profile photo">
              <div className={ps.avatarWrap}>
                <div className={ps.avatar}>
                  {avatarSrc
                    ? <img src={avatarSrc} alt="profile"/>
                    : initials}
                </div>
                <input type="file" accept="image/*"
                  className={ps.avatarInput}
                  onChange={handleAvatarChange}
                  title="Click to change profile picture"/>
              </div>
              <div className={ps.userInfo}>
                <div className={ps.userName}>{displayName}</div>
                <div className={ps.userRole}>{ROLE_LABELS[role]}</div>
              </div>
            </div>
          </div>
        </aside>

        {/* ── Main ── */}
        <main className={ps.main}>
          <div className={ps.pageHeader}>
            <h1 className={ps.pageTitle}>{pt.title}</h1>
            <p  className={ps.pageSub}>{pt.sub}</p>
          </div>
          {renderPage()}
        </main>
      </div>
    </div>
  )
}
