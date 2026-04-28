import React, { useState, useEffect } from 'react'
import DebtorsPage    from './pages/DebtorsPage.jsx'
import StockPage      from './pages/StockPage.jsx'
import { CreditorsPage, GLPage } from './pages/OtherPages.jsx'
import ConversionPage from './pages/ConversionPage.jsx'
import PortalApp      from './portal/PortalApp.jsx'
import api            from './api/bulkApi.js'
import styles         from './App.module.css'

const MODULES = [
  { id:'debtors',   label:'Debtors',       sub:'dl01_mast', page:DebtorsPage },
  { id:'stock',     label:'Stock',          sub:'st01_mast', page:StockPage },
  { id:'creditors', label:'Creditors',      sub:'cl01_mast', page:CreditorsPage },
  { id:'gl',        label:'General ledger', sub:'gl01_mast', page:GLPage },
  { id:'conversion',label:'Data conversion',sub:'sy999',     page:ConversionPage },
]

const PAGE_TITLES = {
  debtors:    { title:'Debtors',           sub:'Export or import debtor accounts from dl01_mast' },
  stock:      { title:'Stock',             sub:'Export or import stock codes from st01_mast' },
  creditors:  { title:'Creditors',         sub:'Export or import creditor accounts from cl01_mast' },
  gl:         { title:'General ledger',    sub:'Export or import GL accounts from gl01_mast' },
  conversion: { title:'Data conversion',   sub:'Full table export and conversion import — sy999' },
}

export default function App() {
  const [mode,       setMode]       = useState('sy195')
  const [active,     setActive]     = useState('debtors')
  const [online,     setOnline]     = useState(null)
  const [collapsed,  setCollapsed]  = useState(false)
  const [mobileOpen, setMobileOpen] = useState(false)

  useEffect(() => { api.checkHealth().then(setOnline) }, [])

  // Close sidebar on mobile when navigating
  function navigate(id) { setActive(id); setMobileOpen(false) }

  if (mode === 'portal') return <PortalApp onBack={() => setMode('sy195')} />

  const ActivePage = MODULES.find(m => m.id === active)?.page

  return (
    <div className={styles.root}>
      {/* ── Topbar ── */}
      <header className={styles.topbar}>
        <button className={styles.hamburger}
          onClick={() => setMobileOpen(v => !v)} aria-label="Toggle menu">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
            <line x1="3" y1="6"  x2="21" y2="6"/>
            <line x1="3" y1="12" x2="21" y2="12"/>
            <line x1="3" y1="18" x2="21" y2="18"/>
          </svg>
        </button>

        <div className={styles.brand}>
          <span className={styles.bx}>XACT</span>
          <span className={styles.be}> ERP</span>
        </div>

        <div className={styles.tbsp}/>

        {/* Mode switcher — hidden on mobile */}
        <div className={styles.modeSwitcher}>
          <button className={`${styles.modeBtn} ${mode==='sy195'?styles.modeBtnActive:''}`}
            onClick={() => setMode('sy195')}>sy195</button>
          <button className={`${styles.modeBtn} ${mode==='portal'?styles.modeBtnActive:''}`}
            onClick={() => setMode('portal')}>Portal</button>
        </div>

        {online !== null && (
          <div className={`${styles.statusDot} ${online?styles.statusOnline:styles.statusOffline}`}>
            <span className={styles.statusDotCircle}/>
            <span className={styles.statusLabel}>{online?'Connected':'Offline'}</span>
          </div>
        )}

        <div className={styles.avatar}>JS</div>
      </header>

      <div className={styles.layout}>
        {/* Overlay for mobile */}
        {mobileOpen && <div className={styles.overlay} onClick={() => setMobileOpen(false)}/>}

        {/* ── Sidebar ── */}
        <aside className={`${styles.sidebar} ${collapsed?styles.collapsed:''} ${mobileOpen?styles.sidebarOpen:''}`}>

          {/* Desktop collapse button — Jira style */}
          <button className={styles.collapseBtn}
            onClick={() => setCollapsed(v => !v)}
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

          <div className={styles.sidebarNav}>
            <p className={styles.sbLabel}>Modules</p>
            {MODULES.slice(0,4).map(m => (
              <button key={m.id}
                className={`${styles.navItem} ${active===m.id?styles.navActive:''}`}
                data-label={m.label}
                onClick={() => navigate(m.id)}>
                <span className={styles.navDot}/>
                <span className={styles.navLabel}>{m.label}</span>
                <span className={styles.navSub}>{m.sub}</span>
              </button>
            ))}

            <div className={styles.sbDivider}/>
            <p className={styles.sbLabel}>Conversion</p>
            <button
              className={`${styles.navItem} ${active==='conversion'?styles.navActive:''}`}
              data-label="Data conversion"
              onClick={() => navigate('conversion')}>
              <span className={styles.navDot}/>
              <span className={styles.navLabel}>Data conversion</span>
              <span className={styles.navSub}>sy999</span>
            </button>

            <div className={styles.sbDivider}/>
            <p className={styles.sbLabel}>Switch</p>
            <button className={styles.navItem} onClick={() => { setMode('portal'); setMobileOpen(false) }}>
              <span className={styles.navDot}/>
              <span className={styles.navLabel}>Partner Portal</span>
            </button>
          </div>

          <div className={styles.sidebarFooter}>
            <p className={styles.footerLine}>sy195 · v3.0</p>
            <p className={styles.footerLine}>Spring Boot + React</p>
          </div>
        </aside>

        {/* ── Main ── */}
        <main className={styles.main}>
          <div className={styles.pageHeader}>
            <h1 className={styles.pageTitle}>{PAGE_TITLES[active]?.title}</h1>
            <p  className={styles.pageSub}>{PAGE_TITLES[active]?.sub}</p>
          </div>
          {ActivePage && <ActivePage />}
        </main>
      </div>
    </div>
  )
}
