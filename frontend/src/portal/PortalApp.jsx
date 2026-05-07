import React, { useState, useRef } from 'react'
import {
  LayoutDashboard, FilePlus2, ClipboardList, LogOut,
  PanelLeftClose, PanelLeftOpen, Sun, Moon, Monitor,
  ArrowLeftRight,
} from 'lucide-react'
import { logout, getSession } from './api/portalApi.js'
import { useTheme } from '../context/ThemeContext.jsx'
import LoginPage          from './pages/LoginPage.jsx'
import PartnerDashboard   from './pages/PartnerDashboard.jsx'
import RegistrationForm   from './pages/RegistrationForm.jsx'
import RegistrationDetail from './pages/RegistrationDetail.jsx'
import ApprovalQueue      from './pages/ApprovalQueue.jsx'
import AdminDashboard     from './pages/AdminDashboard.jsx'
import ps from './PortalApp.module.css'
import xactLogo from '../assets/xact.svg'

const NAV = {
  PARTNER: [
    { id:'dashboard', label:'Dashboard',        Icon: LayoutDashboard },
    { id:'new-reg',   label:'New registration', Icon: FilePlus2 },
  ],
  XACT_ADMIN: [
    { id:'dashboard', label:'All registrations', Icon: LayoutDashboard },
    { id:'queue',     label:'Approval queue',    Icon: ClipboardList },
  ],
  IMPLY: [
    { id:'queue', label:'Pending review', Icon: ClipboardList },
  ],
}

const ROLE_LABELS = {
  PARTNER:'Channel Partner', XACT_ADMIN:'XactERP Admin', IMPLY:'Imply Approver'
}

const AVATAR_KEY = 'pp_avatar'

export default function PortalApp({ onBack }) {
  const [session,    setSession]    = useState(() => getSession())
  const [page,       setPage]       = useState('dashboard')
  const [viewId,     setViewId]     = useState(null)
  const [mobileOpen, setMobileOpen] = useState(false)
  const { theme, setTheme }         = useTheme()

  // Collapsed state — both state (render) and ref (drag closures)
  const [collapsed, setCollapsedState] = useState(false)
  const collapsedRef = useRef(false)
  function setCollapsed(v) { collapsedRef.current = v; setCollapsedState(v) }

  const [avatarSrc, setAvatarSrc] = useState(
    () => localStorage.getItem(AVATAR_KEY) || null
  )

  if (!session) return <LoginPage onLogin={data => { setSession(data); setPage('dashboard') }} />

  const role = session.role
  const nav  = NAV[role] || []

  function handleLogout() { logout(); setSession(null); setPage('dashboard') }

  function handleAvatarChange(e) {
    const file = e.target.files[0]
    if (!file) return
    const reader = new FileReader()
    reader.onload = ev => {
      const dataUrl = ev.target.result
      setAvatarSrc(dataUrl)
      localStorage.setItem(AVATAR_KEY, dataUrl)
    }
    reader.readAsDataURL(file)
  }

  function goViewReg(id)  { setViewId(id); setPage('view-reg'); setMobileOpen(false) }
  function goEditReg(id)  { setViewId(id); setPage('edit-reg'); setMobileOpen(false) }
  function goNewReg()     { setPage('new-reg'); setMobileOpen(false) }
  function goBack()       { setPage('dashboard') }

  function handleNavClick(id) {
    if (id === 'new-reg') { goNewReg(); return }
    setViewId(null); setPage(id); setMobileOpen(false)
  }

  // ── Drag-to-collapse ──────────────────────────────────────────────────
  function onResizeStart(e) {
    const startX = e.clientX
    function onMove(mv) {
      const dx = mv.clientX - startX
      if (!collapsedRef.current && dx < -40) { setCollapsed(true);  done() }
      else if (collapsedRef.current && dx > 40) { setCollapsed(false); done() }
    }
    function done() {
      document.removeEventListener('mousemove', onMove)
      document.removeEventListener('mouseup', done)
    }
    document.addEventListener('mousemove', onMove)
    document.addEventListener('mouseup', done)
    e.preventDefault()
  }

  function renderPage() {
    if (page === 'view-reg' && viewId)
      return <RegistrationDetail regId={viewId} onBack={goBack} />
    if (page === 'edit-reg' && viewId && role === 'PARTNER')
      return <RegistrationForm regId={viewId} onBack={goBack} onDone={() => setPage('dashboard')} />
    if (page === 'new-reg' && role === 'PARTNER')
      return <RegistrationForm onBack={goBack} onDone={() => setPage('dashboard')} />
    if (page === 'queue')
      return <ApprovalQueue session={session} />
    if (role === 'PARTNER')    return <PartnerDashboard session={session} onNewReg={goNewReg} onViewReg={goViewReg} onEditReg={goEditReg} />
    if (role === 'XACT_ADMIN') return <AdminDashboard onViewReg={goViewReg} />
    if (role === 'IMPLY')      return <ApprovalQueue session={session} />
    return null
  }

  const PAGE_TITLES = {
    dashboard:  role==='PARTNER'    ? { title:'Partner dashboard',    sub:'Your company registrations' }
              : role==='XACT_ADMIN' ? { title:'All registrations',    sub:'XactERP admin — all partners' }
              :                       { title:'Imply queue',           sub:'Pending review' },
    'new-reg':  { title:'New company registration', sub:'Step through the registration form' },
    'view-reg': { title:'Registration detail',      sub:'Full registration and workflow history' },
    'edit-reg': { title:'Edit registration',        sub:'Update your draft registration' },
    queue:      role==='IMPLY'
                  ? { title:'Imply approval queue',   sub:'Xact Pro first-stage decisions' }
                  : { title:'XactERP approval queue', sub:'Pending XactERP approval' },
  }
  const pt = PAGE_TITLES[page] || { title:'', sub:'' }
  const activePage = (page === 'view-reg' || page === 'edit-reg') ? 'dashboard' : page

  const initials = session.name
    ? session.name.split(' ').filter(Boolean).map(w=>w[0]).join('').substring(0,2).toUpperCase()
    : 'U'
  const displayName = session.name?.split(' — ')[0] || session.name || session.email

  return (
    <div className={ps.root}>
      {mobileOpen && <div className={ps.overlay} onClick={() => setMobileOpen(false)}/>}

      {/* ── Sidebar ── */}
      <aside className={`${ps.sidebar} ${collapsed ? ps.collapsed : ''} ${mobileOpen ? ps.mobileOpen : ''}`}>

        {/* Brand */}
        <div className={ps.sidebarBrand}>
          <img src={xactLogo} alt="XactERP" className={ps.brandLogo}/>
          <div className={ps.brandText}>
            <span className={ps.bx}>XACT</span>
            <span className={ps.be}>ERP</span>
            <span className={ps.bmod}>Portal</span>
          </div>
        </div>

        {/* Collapse button */}
        <button className={ps.collapseBtn} onClick={() => setCollapsed(!collapsedRef.current)}
          title={collapsed ? 'Expand sidebar' : 'Collapse sidebar'}>
          {collapsed ? <PanelLeftOpen size={14}/> : <PanelLeftClose size={14}/>}
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
              onClick={() => handleNavClick(n.id)}>
              <span className={ps.navIcon}><n.Icon size={20}/></span>
              <span className={ps.navLabel}>{n.label}</span>
            </button>
          ))}

          {onBack && (
            <>
              <div className={ps.sbDivider}/>
              <button className={ps.navItem} data-label="Back to sy195" onClick={() => { setMobileOpen(false); onBack() }}>
                <span className={ps.navIcon}><ArrowLeftRight size={20}/></span>
                <span className={ps.navLabel}>← sy195 tools</span>
              </button>
            </>
          )}
        </div>

        {/* Bottom — theme + sign out + user ── */}
        <div className={ps.sidebarBottom}>
          <div className={ps.themeRow}>
            {[['light',Sun,'Light mode'],['system',Monitor,'System default'],['dark',Moon,'Dark mode']].map(([val,Icon,label]) => (
              <button key={val}
                className={`${ps.themeBtn} ${theme===val ? ps.themeBtnActive : ''}`}
                onClick={() => setTheme(val)}
                data-tooltip={label}>
                <Icon size={13}/>
              </button>
            ))}
          </div>

          <button className={ps.signOutBtn} onClick={handleLogout} data-label="Sign out">
            <span className={ps.navIcon}><LogOut size={20}/></span>
            <span className={ps.navLabel}>Sign out</span>
          </button>

          <div className={ps.sbDivider}/>

          <div className={ps.userCard} data-label="Change profile photo">
            <div className={ps.avatarWrap}>
              <div className={ps.avatar}>
                {avatarSrc ? <img src={avatarSrc} alt="profile"/> : initials}
              </div>
              <input type="file" accept="image/*" className={ps.avatarInput}
                onChange={handleAvatarChange} title="Click to change profile picture"/>
            </div>
            <div className={ps.userInfo}>
              <div className={ps.userName}>{displayName}</div>
              <div className={ps.userRole}>{ROLE_LABELS[role]}</div>
            </div>
          </div>
        </div>

        {/* Drag handle */}
        <div className={ps.resizeHandle} onMouseDown={onResizeStart}/>
      </aside>

      {/* ── Main ── */}
      <main className={ps.main}>
        {/* Mobile sticky bar */}
        <div className={ps.mobileBar}>
          <button className={ps.hamburger} onClick={() => setMobileOpen(v=>!v)}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
              <line x1="3" y1="6"  x2="21" y2="6"/>
              <line x1="3" y1="12" x2="21" y2="12"/>
              <line x1="3" y1="18" x2="21" y2="18"/>
            </svg>
          </button>
          <div className={ps.mobileBrand}>
            <img src={xactLogo} alt="" className={ps.mobileLogo}/>
            <span className={ps.bx}>XACT</span><span className={ps.be}>ERP</span>
            <span className={ps.bmod}>Portal</span>
          </div>
        </div>

        <div className={ps.pageHeader}>
          <h1 className={ps.pageTitle}>{pt.title}</h1>
          <p  className={ps.pageSub}>{pt.sub}</p>
        </div>
        <div className={ps.pageContent}>
          {renderPage()}
        </div>
      </main>
    </div>
  )
}
