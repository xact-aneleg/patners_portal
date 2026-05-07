import { createContext, useContext, useEffect, useState } from 'react'

const STORAGE_KEY = 'xact-theme'
const ThemeContext = createContext(null)

function getSystemTheme() {
  if (typeof window === 'undefined' || !window.matchMedia) return 'light'
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
}

function resolveTheme(pref) {
  return pref === 'system' ? getSystemTheme() : pref
}

function applyTheme(resolved) {
  if (typeof document === 'undefined') return
  document.documentElement.setAttribute('data-theme', resolved)
}

export function ThemeProvider({ children }) {
  const [theme, setThemeState] = useState(
    () => (typeof localStorage !== 'undefined' && localStorage.getItem(STORAGE_KEY)) || 'system'
  )

  useEffect(() => { applyTheme(resolveTheme(theme)) }, [theme])

  useEffect(() => {
    if (theme !== 'system' || typeof window === 'undefined' || !window.matchMedia) return
    const mq = window.matchMedia('(prefers-color-scheme: dark)')
    const handler = () => applyTheme(resolveTheme('system'))
    mq.addEventListener('change', handler)
    return () => mq.removeEventListener('change', handler)
  }, [theme])

  function setTheme(value) {
    if (typeof localStorage !== 'undefined') localStorage.setItem(STORAGE_KEY, value)
    setThemeState(value)
  }

  return (
    <ThemeContext.Provider value={{ theme, setTheme, resolvedTheme: resolveTheme(theme) }}>
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme() {
  const ctx = useContext(ThemeContext)
  if (!ctx) throw new Error('useTheme must be used within ThemeProvider')
  return ctx
}
