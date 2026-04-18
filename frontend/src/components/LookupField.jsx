import React, { useState, useEffect, useRef, useCallback } from 'react'
import axios from 'axios'
import styles from './LookupField.module.css'

export default function LookupField({ label, value, onChange, module, placeholder = 'Search…' }) {
  const [query,   setQuery]   = useState(value || '')
  const [results, setResults] = useState([])
  const [open,    setOpen]    = useState(false)
  const [loading, setLoading] = useState(false)
  const debounceRef   = useRef(null)
  const containerRef  = useRef(null)
  const latestQuery   = useRef('')

  // Sync external value in
  useEffect(() => { setQuery(value || '') }, [value])

  // Close on outside click
  useEffect(() => {
    const handler = (e) => {
      if (containerRef.current && !containerRef.current.contains(e.target)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  }, [])

  const doSearch = useCallback(async (q) => {
    if (!q || q.trim().length === 0) {
      setResults([])
      setOpen(false)
      setLoading(false)
      return
    }
    setLoading(true)
    try {
      const res = await axios.get(`/api/lookup/${module}`, {
        params: { q: q.toUpperCase(), limit: 15 }
      })
      // Only update if this is still the latest query (prevents race conditions)
      if (q === latestQuery.current) {
        const data = res.data || []
        setResults(data)
        setOpen(data.length > 0)
      }
    } catch (err) {
      console.error('Lookup error:', err)
      setResults([])
      setOpen(false)
    } finally {
      if (q === latestQuery.current) setLoading(false)
    }
  }, [module])

  const handleChange = (e) => {
    const v = e.target.value.toUpperCase()
    setQuery(v)
    onChange(v)
    latestQuery.current = v
    clearTimeout(debounceRef.current)
    if (!v) {
      setResults([])
      setOpen(false)
      setLoading(false)
      return
    }
    debounceRef.current = setTimeout(() => doSearch(v), 200)
  }

  const handleFocus = () => {
    if (query && results.length > 0) setOpen(true)
    else if (query) doSearch(query)
  }

  const handleSelect = (item) => {
    setQuery(item.code)
    onChange(item.code)
    setResults([])
    setOpen(false)
  }

  const handleKeyDown = (e) => {
    if (e.key === 'Escape') setOpen(false)
  }

  return (
    <div className={styles.wrap} ref={containerRef}>
      {label && <label>{label}</label>}
      <div className={styles.inputWrap}>
        <input
          value={query}
          onChange={handleChange}
          onFocus={handleFocus}
          onKeyDown={handleKeyDown}
          placeholder={placeholder}
          autoComplete="off"
          spellCheck="false"
          className={styles.input}
        />
        {loading
          ? <span className={styles.spinner} />
          : <span className={styles.icon}><SearchIcon /></span>
        }
      </div>
      {open && results.length > 0 && (
        <div className={styles.dropdown}>
          {results.map((item, i) => (
            <button
              key={i}
              className={styles.item}
              onMouseDown={(e) => { e.preventDefault(); handleSelect(item) }}
              type="button"
            >
              <span className={styles.code}>{item.code}</span>
              {item.name && <span className={styles.name}>{item.name}</span>}
            </button>
          ))}
        </div>
      )}
    </div>
  )
}

const SearchIcon = () => (
  <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
    <circle cx="6" cy="6" r="4.5" stroke="currentColor" strokeWidth="1.4"/>
    <path d="M9.5 9.5L12 12" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/>
  </svg>
)
