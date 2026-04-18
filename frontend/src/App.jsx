import React, { useState, useEffect } from 'react'
import DebtorsPage    from './pages/DebtorsPage.jsx'
import StockPage      from './pages/StockPage.jsx'
import { CreditorsPage, GLPage } from './pages/OtherPages.jsx'
import ConversionPage from './pages/ConversionPage.jsx'
import PortalApp      from './portal/PortalApp.jsx'
import api            from './api/bulkApi.js'
import styles         from './App.module.css'
import xactLogo       from './assets/xact.svg'

const BULK_MODULES = [
  { id:'debtors',   label:'Debtors',       sub:'dl01_mast', page:DebtorsPage },
  { id:'stock',     label:'Stock',          sub:'st01_mast', page:StockPage },
  { id:'creditors', label:'Creditors',      sub:'cl01_mast', page:CreditorsPage },
  { id:'gl',        label:'General ledger', sub:'gl01_mast', page:GLPage },
]

const PAGE_TITLES = {
  debtors:    { title:'Debtors',            sub:'Export or import debtor accounts from dl01_mast' },
  stock:      { title:'Stock',              sub:'Export or import stock codes from st01_mast' },
  creditors:  { title:'Creditors',          sub:'Export or import creditor accounts from cl01_mast' },
  gl:         { title:'General ledger',     sub:'Export or import GL accounts from gl01_mast' },
  conversion: { title:'Data conversion',    sub:'Full table export and conversion import — sy999' },
}

export default function App() {
  const [mode,   setMode]   = useState('sy195')
  const [active, setActive] = useState('debtors')
  const [online, setOnline] = useState(null)

  useEffect(() => { api.checkHealth().then(setOnline) }, [])

  if (mode === 'portal') return <PortalApp />

  const ActivePage = [...BULK_MODULES, { id:'conversion', page:ConversionPage }]
                      .find(m => m.id === active)?.page

  return (
    <div className={styles.root}>
      {/* ── Topbar ── */}
      <header className={styles.topbar}>
        <div className={styles.topbarBrand}>
          <img src={xactLogo} alt="XactERP" className={styles.topbarLogoIcon} />
          <span className={styles.topbarXact}>XACT</span>
          <span className={styles.topbarErp}>ERP</span>
          <span className={styles.topbarModule}>Bulk Import / Export</span>
        </div>
        <div className={styles.topbarSpacer}/>

        {/* Mode switcher */}
        <div className={styles.modeSwitcher}>
          <button
            className={`${styles.modeBtn} ${mode==='sy195'  ? styles.modeBtnActive:''}`}
            onClick={() => setMode('sy195')}>sy195</button>
          <button
            className={`${styles.modeBtn} ${mode==='portal' ? styles.modeBtnActive:''}`}
            onClick={() => setMode('portal')}>Partner Portal</button>
        </div>

        {online !== null && (
          <div className={`${styles.statusDot} ${online ? styles.statusOnline : styles.statusOffline}`}>
            <span className={styles.statusDotCircle}/>
            <span className={styles.statusLabel}>{online ? 'Connected' : 'API offline'}</span>
          </div>
        )}
        <div className={styles.topbarAvatar}>JS</div>
      </header>

      <div className={styles.layout}>
        {/* ── Sidebar ── */}
        <aside className={styles.sidebar}>
          <p className={styles.sidebarLabel}>Modules</p>
          <nav>
            {BULK_MODULES.map(m => (
              <button key={m.id}
                className={`${styles.navItem} ${active===m.id ? styles.navActive:''}`}
                onClick={() => setActive(m.id)}>
                <span className={styles.navDot}/>
                <span className={styles.navLabel}>{m.label}</span>
                <span className={styles.navSub}>{m.sub}</span>
              </button>
            ))}
          </nav>

          <div className={styles.sidebarDivider}/>
          <p className={styles.sidebarLabel}>Conversion</p>
          <nav>
            <button
              className={`${styles.navItem} ${active==='conversion' ? styles.navActive:''}`}
              onClick={() => setActive('conversion')}>
              <span className={styles.navDot}/>
              <span className={styles.navLabel}>Data conversion</span>
              <span className={styles.navSub}>sy999</span>
            </button>
          </nav>

          <div className={styles.sidebarFooter}>
            <p className={styles.footerLine}>sy195 · v3.0</p>
            <p className={styles.footerLine}>Spring Boot + React</p>
          </div>
        </aside>

        {/* ── Main ── */}
        <main className={styles.main}>
          <div className={styles.pageHeader}>
            <div>
              <h1 className={styles.pageTitle}>{PAGE_TITLES[active]?.title}</h1>
              <p  className={styles.pageSub}>{PAGE_TITLES[active]?.sub}</p>
            </div>
          </div>
          {ActivePage && <ActivePage />}
        </main>
      </div>
    </div>
  )
}
