import React, { useState, useEffect, useRef } from 'react'
import {
  Users, Package, Building2, BookOpen, ArrowRightLeft, Globe,
  PanelLeftClose, PanelLeftOpen, Sun, Moon, Monitor,
} from 'lucide-react'
import { useTheme } from './context/ThemeContext.jsx'
import DebtorsPage    from './pages/DebtorsPage.jsx'
import StockPage      from './pages/StockPage.jsx'
import { CreditorsPage, GLPage } from './pages/OtherPages.jsx'
import ConversionPage from './pages/ConversionPage.jsx'
import PortalApp      from './portal/PortalApp.jsx'
import api            from './api/bulkApi.js'
import styles         from './App.module.css'
import xactLogo       from './assets/xact.svg'

const MODULES = [
  { id:'debtors',    label:'Debtors',        sub:'dl01_mast', page:DebtorsPage,    Icon:Users },
  { id:'stock',      label:'Stock',          sub:'st01_mast', page:StockPage,      Icon:Package },
  { id:'creditors',  label:'Creditors',      sub:'cl01_mast', page:CreditorsPage,  Icon:Building2 },
  { id:'gl',         label:'General ledger', sub:'gl01_mast', page:GLPage,         Icon:BookOpen },
]

const PAGE_TITLES = {
  debtors:    { title:'Debtors',         sub:'Export or import debtor accounts from dl01_mast' },
  stock:      { title:'Stock',           sub:'Export or import stock codes from st01_mast' },
  creditors:  { title:'Creditors',       sub:'Export or import creditor accounts from cl01_mast' },
  gl:         { title:'General ledger',  sub:'Export or import GL accounts from gl01_mast' },
  conversion: { title:'Data conversion', sub:'Full table export and conversion import — sy999' },
}

export default function App() {
  const [mode,       setMode]         = useState('sy195')
  const [active,     setActive]       = useState('debtors')
  const [online,     setOnline]       = useState(null)
  const [mobileOpen, setMobileOpen]   = useState(false)
  const { theme, setTheme }           = useTheme()

  // Collapsed state kept in both state (for render) and ref (for drag handler closures)
  const [collapsed, setCollapsedState] = useState(false)
  const collapsedRef = useRef(false)
  function setCollapsed(v) { collapsedRef.current = v; setCollapsedState(v) }

  useEffect(() => { api.checkHealth().then(setOnline) }, [])

  function navigate(id) { setActive(id); setMobileOpen(false) }

  // ── Drag-to-collapse on sidebar right edge ──────────────────────────────
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

  if (mode === 'portal') return <PortalApp onBack={() => setMode('sy195')} />

  const ActivePage = MODULES.find(m => m.id === active)?.page
    ?? (active === 'conversion' ? ConversionPage : null)

  return (
    <div className={styles.root}>
      {mobileOpen && <div className={styles.overlay} onClick={() => setMobileOpen(false)}/>}

      {/* ── Sidebar ── */}
      <aside className={`${styles.sidebar} ${collapsed?styles.collapsed:''} ${mobileOpen?styles.sidebarOpen:''}`}>

        {/* Brand */}
        <div className={styles.sidebarBrand}>
          <img src={xactLogo} alt="XactERP" className={styles.brandLogo}/>
          <div className={styles.brandText}>
            <span className={styles.bx}>XACT</span>
            <span className={styles.be}>ERP</span>
          </div>
        </div>

        {/* Collapse button */}
        <button className={styles.collapseBtn}
          onClick={() => setCollapsed(!collapsedRef.current)}
          title={collapsed ? 'Expand sidebar' : 'Collapse sidebar'}>
          {collapsed ? <PanelLeftOpen size={14}/> : <PanelLeftClose size={14}/>}
        </button>

        {/* Nav */}
        <div className={styles.sidebarNav}>
          <p className={styles.sbLabel}>Modules</p>
          {MODULES.map(m => (
            <button key={m.id}
              className={`${styles.navItem} ${active===m.id?styles.navActive:''}`}
              data-label={m.label}
              onClick={() => navigate(m.id)}>
              <span className={styles.navIcon}><m.Icon size={20}/></span>
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
            <span className={styles.navIcon}><ArrowRightLeft size={20}/></span>
            <span className={styles.navLabel}>Data conversion</span>
            <span className={styles.navSub}>sy999</span>
          </button>

          <div className={styles.sbDivider}/>
          <p className={styles.sbLabel}>Switch</p>
          <button className={styles.navItem}
            data-label="Partner Portal"
            onClick={() => { setMode('portal'); setMobileOpen(false) }}>
            <span className={styles.navIcon}><Globe size={20}/></span>
            <span className={styles.navLabel}>Partner Portal</span>
          </button>
        </div>

        {/* Footer — status + theme + version */}
        <div className={styles.sidebarFooter}>
          {online !== null && (
            <div className={`${styles.statusRow} ${online?styles.statusOnline:styles.statusOffline}`}>
              <span className={styles.statusDot}/>
              <span className={styles.statusLabel}>{online?'Connected':'Offline'}</span>
            </div>
          )}
          <div className={styles.themeRow}>
            {[['light',Sun,'Light mode'],['system',Monitor,'System default'],['dark',Moon,'Dark mode']].map(([val,Icon,label]) => (
              <button key={val}
                className={`${styles.themeBtn} ${theme===val?styles.themeBtnActive:''}`}
                onClick={() => setTheme(val)}
                data-tooltip={label}>
                <Icon size={13}/>
              </button>
            ))}
          </div>
          <p className={styles.footerLine}>sy195 · v3.0</p>
          <p className={styles.footerLine}>Spring Boot + React</p>
        </div>

        {/* Drag handle */}
        <div className={styles.resizeHandle} onMouseDown={onResizeStart}/>
      </aside>

      {/* ── Main ── */}
      <main className={styles.main}>
        {/* Mobile-only sticky bar */}
        <div className={styles.mobileBar}>
          <button className={styles.hamburger} onClick={() => setMobileOpen(v=>!v)} aria-label="Menu">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
              <line x1="3" y1="6"  x2="21" y2="6"/>
              <line x1="3" y1="12" x2="21" y2="12"/>
              <line x1="3" y1="18" x2="21" y2="18"/>
            </svg>
          </button>
          <span className={styles.mobileBrand}>
            <span className={styles.bx}>XACT</span><span className={styles.be}>ERP</span>
          </span>
        </div>

        <div className={styles.pageHeader}>
          <h1 className={styles.pageTitle}>{PAGE_TITLES[active]?.title}</h1>
          <p  className={styles.pageSub}>{PAGE_TITLES[active]?.sub}</p>
        </div>
        <div className={styles.pageContent}>
          {ActivePage && <ActivePage/>}
        </div>
      </main>
    </div>
  )
}
