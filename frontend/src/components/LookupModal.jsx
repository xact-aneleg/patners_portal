import React, { useState, useEffect, useRef, useCallback } from 'react'
import api from '../api/bulkApi.js'
import s from './LookupModal.module.css'

const MODULE_META = {
  debtors: {
    title: 'Debtor Code Lookup',
    heading: 'DEBTOR CODE LOOKUP',
    cols: [
      { key: 'code',     label: 'Code',      w: 110 },
      { key: 'fileCode', label: 'File Code', w: 90  },
      { key: 'name',     label: 'Name',      flex: true },
      { key: 'loc',      label: 'Loc',       w: 55  },
    ],
  },
  stock: {
    title: 'Stock Code Lookup',
    heading: 'STOCK CODE LOOKUP',
    cols: [
      { key: 'code',   label: 'Stock Code',  w: 160 },
      { key: 'name',   label: 'Description', flex: true },
      { key: 'uomQty', label: 'Sale/UOM',    w: 100 },
      { key: 'status', label: 'Status',      w: 60  },
    ],
  },
  creditors: {
    title: 'Creditors Code Lookup',
    heading: 'CREDITORS CODE LOOKUP',
    cols: [
      { key: 'code',     label: 'Code',      w: 120 },
      { key: 'prevCode', label: 'Prev Code', w: 90  },
      { key: 'name',     label: 'Name',      flex: true },
      { key: 'bee',      label: 'BEE',       w: 50  },
    ],
  },
  gl: {
    title: 'GL Code Lookup',
    heading: 'GL CODE LOOKUP',
    cols: [
      { key: 'code',   label: 'GL Code',     w: 110 },
      { key: 'name',   label: 'Description', flex: true },
      { key: 'type',   label: 'Type',        w: 55  },
      { key: 'status', label: 'Status',      w: 60  },
    ],
  },
}

const LIMIT = 300

export default function LookupModal({ module, value, onSelect, onClose }) {
  const meta = MODULE_META[module]

  const [rows,    setRows]    = useState([])
  const [filter,  setFilter]  = useState('')
  const [selIdx,  setSelIdx]  = useState(0)
  const [loading, setLoading] = useState(false)

  const filterRef  = useRef(null)
  const tbodyRef   = useRef(null)
  const debounceRef = useRef(null)

  const doSearch = useCallback(async (q) => {
    setLoading(true)
    try {
      // empty string or '*' both mean "fetch all"
      const actual = (q === '' || q === '*') ? '' : q
      const data = await api.lookup(module, actual, LIMIT)
      setRows(data)
      const idx = value ? data.findIndex(r => r.code === value) : -1
      setSelIdx(idx >= 0 ? idx : 0)
    } catch {
      setRows([])
    } finally {
      setLoading(false)
    }
  }, [module, value])

  // Auto-load all records on open, focus the filter field
  useEffect(() => {
    doSearch('')
    const t = setTimeout(() => filterRef.current?.focus(), 60)
    return () => clearTimeout(t)
  }, [])

  // Scroll selected row into view
  useEffect(() => {
    if (tbodyRef.current) {
      const el = tbodyRef.current.children[selIdx]
      el?.scrollIntoView({ block: 'nearest' })
    }
  }, [selIdx])

  function handleFilterChange(e) {
    const v = e.target.value.toUpperCase()
    setFilter(v)
    clearTimeout(debounceRef.current)
    // empty or '*' both fetch all; otherwise filter by typed text
    debounceRef.current = setTimeout(() => doSearch(v), 220)
  }

  function handleSelect(row) {
    onSelect(row.code)
    onClose()
  }

  function handleKeyDown(e) {
    if (e.key === 'Escape') { onClose(); return }
    if (e.key === 'ArrowDown') {
      e.preventDefault()
      setSelIdx(i => Math.min(i + 1, rows.length - 1))
    } else if (e.key === 'ArrowUp') {
      e.preventDefault()
      setSelIdx(i => Math.max(i - 1, 0))
    } else if (e.key === 'Enter') {
      if (rows[selIdx]) handleSelect(rows[selIdx])
    } else if (e.ctrlKey && e.key.toLowerCase() === 'f') {
      e.preventDefault()
      filterRef.current?.select()
      filterRef.current?.focus()
    }
  }

  if (!meta) return null

  return (
    <div className={s.overlay} onKeyDown={handleKeyDown} tabIndex={-1}>
      <div className={s.dialog}>

        {/* Title bar */}
        <div className={s.titleBar}>
          <span className={s.titleText}>{meta.title}</span>
          <button className={s.closeBtn} onClick={onClose} title="Close">✕</button>
        </div>

        {/* Green heading */}
        <div className={s.heading}>{meta.heading}</div>

        {/* Column headers */}
        <div className={s.thead}>
          {meta.cols.map(col => (
            <div key={col.key} className={s.th}
              style={col.flex ? { flex: 1 } : { width: col.w, flexShrink: 0 }}>
              {col.label}
            </div>
          ))}
        </div>

        {/* Rows */}
        <div className={s.tbody} ref={tbodyRef}>
          {loading && <div className={s.centerMsg}>Loading…</div>}
          {!loading && rows.length === 0 && (
            <div className={s.centerMsg}>No records found</div>
          )}
          {!loading && rows.map((row, i) => (
            <div
              key={i}
              className={`${s.tr} ${i === selIdx ? s.trSel : i % 2 === 0 ? s.trEven : s.trOdd}`}
              onClick={() => setSelIdx(i)}
              onDoubleClick={() => handleSelect(row)}
            >
              {meta.cols.map(col => (
                <div key={col.key} className={s.td}
                  style={col.flex ? { flex: 1 } : { width: col.w, flexShrink: 0 }}>
                  {row[col.key] || ''}
                </div>
              ))}
            </div>
          ))}
        </div>

        {/* Filter row */}
        <div className={s.filterRow}>
          <span className={s.filterLabel}>Filter:</span>
          <input
            ref={filterRef}
            className={s.filterInput}
            value={filter}
            onChange={handleFilterChange}
            onKeyDown={handleKeyDown}
            placeholder="Type to filter  —  * to show all"
            autoComplete="off"
            spellCheck="false"
          />
        </div>

        {/* Status bar */}
        <div className={s.statusBar}>
          <span>CTRL-F to refine search &nbsp;-or-&nbsp; ENTER/DOUBLECLICK to select current row</span>
          <span>OVR</span>
        </div>

      </div>
    </div>
  )
}
