import React, { useState, useEffect } from 'react'
import { Bell, CheckCheck, ChevronLeft, ChevronRight } from 'lucide-react'
import { getNotifications, markAllRead } from '../api/portalApi.js'
import s from './Portal.module.css'

const PAGE_SIZE = 8

const TYPE_META = {
  NEW_SUBMISSION: { label:'New submission', color:'#fbba00' },
  ESCALATED:      { label:'Escalated',      color:'#ff8c00' },
  LIVE:           { label:'Live',           color:'#3aaa35' },
  APPROVED:       { label:'Approved',       color:'#3aaa35' },
  DECLINED:       { label:'Declined',       color:'#dc3545' },
}

function fmt(d) {
  if (!d) return ''
  return new Date(d).toLocaleDateString('en-ZA', {
    day:'numeric', month:'short', year:'numeric',
    hour:'2-digit', minute:'2-digit',
  })
}

export default function NotificationsPage() {
  const [all,   setAll]   = useState([])
  const [page,  setPage]  = useState(0)
  const [busy,  setBusy]  = useState(false)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    getNotifications()
      .then(data => { setAll(data); setLoading(false) })
      .catch(() => setLoading(false))
  }, [])

  async function handleMarkAllRead() {
    setBusy(true)
    await markAllRead().catch(() => {})
    setAll(prev => prev.map(n => ({ ...n, read: true })))
    setBusy(false)
  }

  const unreadCount  = all.filter(n => !n.read).length
  const totalPages   = Math.ceil(all.length / PAGE_SIZE)
  const paged        = all.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE)

  if (loading) return (
    <div className={s.page}>
      <div style={{padding:40,textAlign:'center',color:'var(--color-text-muted)'}}>Loading…</div>
    </div>
  )

  return (
    <div className={s.page}>

      {/* Header row */}
      <div className={s.notifPageHeader}>
        <div>
          <div className={s.notifPageCount}>
            {all.length} notification{all.length !== 1 ? 's' : ''}
            {unreadCount > 0 && (
              <span className={s.notifPageUnreadBadge}>{unreadCount} unread</span>
            )}
          </div>
        </div>
        {unreadCount > 0 && (
          <button className={s.notifMarkAllBtn} onClick={handleMarkAllRead} disabled={busy}>
            <CheckCheck size={14}/> Mark all as read
          </button>
        )}
      </div>

      {/* Empty state */}
      {all.length === 0 ? (
        <div className={s.notifPageEmpty}>
          <Bell size={36} style={{color:'var(--color-text-muted)',marginBottom:10}}/>
          <div style={{fontWeight:700,fontSize:14,color:'var(--color-text)'}}>No notifications yet</div>
          <div style={{fontSize:13,color:'var(--color-text-muted)',marginTop:4}}>
            Notifications will appear here when workflow events occur
          </div>
        </div>
      ) : (
        <>
          {/* Notification list */}
          <div className={s.notifPageList}>
            {paged.map(n => {
              const meta  = TYPE_META[n.type] || { label: n.type, color:'var(--color-text-muted)' }
              return (
                <div key={n.id} className={`${s.notifPageItem} ${!n.read ? s.notifPageItemUnread : ''}`}>
                  <div className={s.notifPageDot} style={{background: meta.color}}/>
                  <div className={s.notifPageContent}>
                    <div className={s.notifPageMsg}>{n.message}</div>
                    <div className={s.notifPageMeta}>
                      <span className={s.notifPageBadge}
                        style={{background: meta.color + '22', color: meta.color}}>
                        {meta.label}
                      </span>
                      <span className={s.notifPageDate}>{fmt(n.createdAt)}</span>
                    </div>
                  </div>
                  {!n.read && <div className={s.notifPageNewPill}>New</div>}
                </div>
              )
            })}
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className={s.pagination}>
              <button className={s.pgBtn} disabled={page === 0} onClick={() => setPage(p => p - 1)}>
                <ChevronLeft size={15}/> Prev
              </button>
              <span className={s.pgInfo}>Page {page + 1} of {totalPages}</span>
              <button className={s.pgBtn} disabled={page === totalPages - 1} onClick={() => setPage(p => p + 1)}>
                Next <ChevronRight size={15}/>
              </button>
            </div>
          )}
        </>
      )}
    </div>
  )
}
