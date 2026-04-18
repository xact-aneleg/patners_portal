import React, { useState } from 'react'
import { logout, getSession } from './api/portalApi.js'
import LoginPage          from './pages/LoginPage.jsx'
import PartnerDashboard   from './pages/PartnerDashboard.jsx'
import RegistrationForm   from './pages/RegistrationForm.jsx'
import RegistrationDetail from './pages/RegistrationDetail.jsx'
import ApprovalQueue      from './pages/ApprovalQueue.jsx'
import AdminDashboard     from './pages/AdminDashboard.jsx'
import ps from './PortalApp.module.css'
import xactLogo from '../assets/xact.svg'

// Sidebar nav items per role
const NAV = {
  PARTNER: [
    { id:'dashboard',   label:'Dashboard',          icon:'⊞' },
    { id:'new-reg',     label:'New registration',   icon:'+' },
  ],
  XACT_ADMIN: [
    { id:'dashboard',   label:'All registrations',  icon:'⊞' },
    { id:'queue',       label:'Approval queue',      icon:'✓' },
  ],
  IMPLY: [
    { id:'queue',       label:'Pending review',      icon:'✓' },
  ],
}

export default function PortalApp() {
  const [session, setSession] = useState(() => getSession())
  const [page,    setPage]    = useState('dashboard')
  const [viewId,  setViewId]  = useState(null)

  if (!session) {
    return <LoginPage onLogin={data => { setSession(data); setPage('dashboard') }} />
  }

  const role = session.role
  const nav  = NAV[role] || []

  function handleLogout() {
    logout()
    setSession(null)
    setPage('dashboard')
  }

  function goViewReg(id) { setViewId(id); setPage('view-reg') }
  function goNewReg()     { setPage('new-reg') }
  function goBack()       { setPage('dashboard') }

  // Render active page
  function renderPage() {
    if (page === 'view-reg' && viewId) {
      return <RegistrationDetail regId={viewId} onBack={goBack} />
    }
    if (page === 'new-reg' && role === 'PARTNER') {
      return <RegistrationForm onBack={goBack} onDone={() => { setPage('dashboard') }} />
    }
    if (page === 'queue') {
      return <ApprovalQueue session={session} />
    }
    if (role === 'PARTNER') {
      return <PartnerDashboard session={session} onNewReg={goNewReg} onViewReg={goViewReg} />
    }
    if (role === 'XACT_ADMIN') {
      return <AdminDashboard onViewReg={goViewReg} />
    }
    if (role === 'IMPLY') {
      return <ApprovalQueue session={session} />
    }
    return <div>Unknown role</div>
  }

  // Page title per page+role
  const PAGE_TITLES = {
    'dashboard':  role==='PARTNER' ? { title:'Partner dashboard',        sub:'Your company registrations' }
                : role==='XACT_ADMIN' ? { title:'All registrations',     sub:'XactERP admin — all partners' }
                : { title:'Imply queue', sub:'Pending review' },
    'new-reg':    { title:'New company registration', sub:'Step through the registration form' },
    'view-reg':   { title:'Registration detail',      sub:'Full registration and workflow history' },
    'queue':      { title: role==='IMPLY' ? 'Imply approval queue' : 'XactERP approval queue',
                    sub:   role==='IMPLY' ? 'Xact Pro first-stage decisions' : 'Pending XactERP approval' },
  }
  const pt = PAGE_TITLES[page] || { title:'', sub:'' }

  const activePage = page === 'view-reg' ? 'dashboard' : page

  return (
    <div className={ps.root}>
      {/* Topbar */}
      <header className={ps.topbar}>
        <div className={ps.brand}>
          <img src={xactLogo} alt="XactERP" className={ps.blogo} />
          <span className={ps.bx}>XACT</span><span className={ps.be}>ERP</span>
          <span className={ps.bmod}>Partner Portal</span>
        </div>
        <div className={ps.tbsp}/>
        <div className={ps.userBadge}>
          <div className={ps.userDot} style={{
            background: role==='PARTNER'?'#39B54A':role==='XACT_ADMIN'?'#3D5166':'#534AB7'
          }}>
            {role==='PARTNER'?'P':role==='XACT_ADMIN'?'X':'I'}
          </div>
          <div>
            <div className={ps.userName}>{session.name?.split(' — ')[1] || session.name}</div>
            <div className={ps.userRole}>{role==='PARTNER'?'Channel Partner':role==='XACT_ADMIN'?'XactERP Admin':'Imply Approver'}</div>
          </div>
        </div>
        <button className={ps.logoutBtn} onClick={handleLogout}>Sign out</button>
      </header>

      <div className={ps.layout}>
        {/* Sidebar */}
        <aside className={ps.sidebar}>
          <div className={ps.sbLabel}>
            {role==='PARTNER'?'Partner menu':role==='XACT_ADMIN'?'Admin menu':'Imply menu'}
          </div>
          {nav.map(n => (
            <button key={n.id}
              className={`${ps.navItem} ${activePage===n.id ? ps.navActive : ''}`}
              onClick={() => { setViewId(null); setPage(n.id) }}
            >
              <span className={ps.navIcon}>{n.icon}</span>
              <span className={ps.navLabel}>{n.label}</span>
            </button>
          ))}

          {/* Role indicator */}
          <div className={ps.sbDivider}/>
          <div className={ps.roleCard} style={{
            borderLeftColor: role==='PARTNER'?'#39B54A':role==='XACT_ADMIN'?'#3D5166':'#534AB7'
          }}>
            <div className={ps.roleLabel}>Signed in as</div>
            <div className={ps.roleName}>{role==='PARTNER'?'Channel Partner':role==='XACT_ADMIN'?'XactERP Admin':'Imply Approver'}</div>
          </div>
        </aside>

        {/* Main */}
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
