import React, { useState, useEffect } from 'react'
import { Plus, ChevronLeft, ChevronRight, Trash2, AlertTriangle } from 'lucide-react'
import { listMyRegistrations, submitRegistration, deleteRegistration } from '../api/portalApi.js'
import StatusPill from '../components/StatusPill.jsx'
import s from './Dashboard.module.css'

const PAGE_SIZE = 8

export default function PartnerDashboard({ session, onNewReg, onViewReg, onEditReg }) {
  const [regs,          setRegs]          = useState([])
  const [err,           setErr]           = useState(null)
  const [busy,          setBusy]          = useState(false)
  const [page,          setPage]          = useState(0)
  const [confirmDelete, setConfirmDelete] = useState(null) // { id, name }

  useEffect(() => {
    listMyRegistrations()
      .then(data => { setRegs(data); setPage(0) })
      .catch(() => setErr('Failed to load registrations'))
  }, [])

  async function handleSubmit(id) {
    setBusy(true)
    try {
      const updated = await submitRegistration(id)
      setRegs(prev => prev.map(r => r.id === id ? { ...r, status: updated.status } : r))
    } catch (e) {
      setErr('Failed to submit: ' + (e.response?.data?.message || e.message))
    } finally { setBusy(false) }
  }

  function handleDelete(id, companyName) {
    setConfirmDelete({ id, name: companyName || 'Untitled draft' })
  }

  async function confirmDeleteNow() {
    if (!confirmDelete) return
    const { id } = confirmDelete
    setConfirmDelete(null)
    setBusy(true)
    try {
      await deleteRegistration(id)
      setRegs(prev => prev.filter(r => r.id !== id))
    } catch (e) {
      setErr('Failed to delete: ' + (e.response?.data?.message || e.message))
    } finally { setBusy(false) }
  }

  const total   = regs.length
  const pending = regs.filter(r => r.status?.includes('PENDING')).length
  const conv    = regs.filter(r => r.status === 'CONVERTING').length
  const live    = regs.filter(r => r.status === 'LIVE').length

  const totalPages  = Math.ceil(total / PAGE_SIZE)
  const paged       = regs.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE)

  return (
    <div className={s.page}>
      {/* ── Delete confirmation modal ── */}
      {confirmDelete && (
        <div className={s.modalOverlay} onClick={() => setConfirmDelete(null)}>
          <div className={s.modal} onClick={e => e.stopPropagation()}>
            <div className={s.modalIcon}><AlertTriangle size={28} /></div>
            <h3 className={s.modalTitle}>Delete draft?</h3>
            <p className={s.modalBody}>
              <strong>{confirmDelete.name}</strong> will be permanently deleted.
              This cannot be undone.
            </p>
            <div className={s.modalActions}>
              <button className={s.modalCancel} onClick={() => setConfirmDelete(null)}>
                Cancel
              </button>
              <button className={s.modalConfirm} onClick={confirmDeleteNow}>
                <Trash2 size={14}/> Delete draft
              </button>
            </div>
          </div>
        </div>
      )}

      {err && (
        <div className={s.err}>
          {err}
          <button onClick={() => setErr(null)}>×</button>
        </div>
      )}

      {/* Compact stats strip */}
      <div className={s.statStrip}>
        <div className={s.statItem}>
          <span className={s.statN} style={{color:'var(--color-grey)'}}>{total}</span>
          <span className={s.statL}>Total</span>
        </div>
        <div className={s.statDivider}/>
        <div className={s.statItem}>
          <span className={s.statN} style={{color:'var(--color-warning)'}}>{pending}</span>
          <span className={s.statL}>Pending</span>
        </div>
        <div className={s.statDivider}/>
        <div className={s.statItem}>
          <span className={s.statN} style={{color:'var(--color-primary)'}}>{conv}</span>
          <span className={s.statL}>Converting</span>
        </div>
        <div className={s.statDivider}/>
        <div className={s.statItem}>
          <span className={s.statN} style={{color:'var(--color-success)'}}>{live}</span>
          <span className={s.statL}>Live</span>
        </div>
      </div>

      {/* Section header */}
      <div className={s.sectionHeader}>
        <span className={s.sectionTitle}>My Registrations</span>
        <button className={s.btnNew} onClick={onNewReg}>
          <Plus size={15} />
          New registration
        </button>
      </div>

      {regs.length === 0
        ? (
          <div className={s.empty}>
            No registrations yet.{' '}
            <button className={s.linkBtn} onClick={onNewReg}>Create your first one →</button>
          </div>
        )
        : (
          <>
            <div className={s.regList}>
              {/* Desktop table header */}
              <div className={s.tableHeader}>
                <span>Company</span>
                <span>Package</span>
                <span>Status</span>
                <span>Submitted</span>
                <span>Actions</span>
              </div>

              {paged.map(r => (
                <div key={r.id} className={s.regCard}>
                  <div className={s.colCompany}>
                    <span className={s.regName}>
                      {r.companyName || <em className={s.unnamed}>Untitled draft</em>}
                    </span>
                    <div className={s.mobileTags}>
                      <span className={s.regPkg}>{r.packageType}</span>
                      <StatusPill status={r.status} />
                    </div>
                  </div>
                  <div className={s.colPackage}>
                    <span className={s.regPkg}>{r.packageType}</span>
                  </div>
                  <div className={s.colStatus}>
                    <StatusPill status={r.status} />
                  </div>
                  <div className={s.colDate}>
                    {r.submittedAt
                      ? new Date(r.submittedAt).toLocaleDateString('en-ZA')
                      : <span className={s.noDate}>—</span>}
                  </div>
                  <div className={s.colActions}>
                    {(r.status === 'DRAFT' || r.status?.startsWith('DECLINED'))
                      ? <button className={s.btnEdit} onClick={() => onEditReg(r.id)}>Edit</button>
                      : <button className={s.btnView} onClick={() => onViewReg(r.id)}>View →</button>
                    }
                    {r.status === 'DRAFT' && (
                      <button className={s.btnSubmit} onClick={() => handleSubmit(r.id)} disabled={busy}>
                        Submit
                      </button>
                    )}
                    {r.status === 'DRAFT' && (
                      <button className={s.btnDelete} onClick={() => handleDelete(r.id, r.companyName)} disabled={busy} title="Delete draft">
                        <Trash2 size={13}/>
                      </button>
                    )}
                  </div>
                </div>
              ))}
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
        )
      }
    </div>
  )
}
