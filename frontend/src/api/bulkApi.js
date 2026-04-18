import axios from 'axios'

const api = axios.create({ baseURL: '/api' })

// ── Export ────────────────────────────────────────────────────────────────────

async function exportModule(module, filters) {
  const res = await api.post(`/export/${module}`, filters, { responseType: 'blob' })
  const cd  = res.headers['content-disposition'] || ''
  const match = cd.match(/filename="?([^"]+)"?/)
  const filename = match ? match[1] : `${module}_export.xlsx`
  triggerDownload(res.data, filename)
}

async function downloadTemplate(module) {
  const res = await api.get(`/export/${module}/template`, { responseType: 'blob' })
  triggerDownload(res.data, `${module}_import_template.xlsx`)
}

// ── Import ────────────────────────────────────────────────────────────────────

async function importModule(module, file) {
  const form = new FormData()
  form.append('file', file)
  const res = await api.post(`/import/${module}`, form, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
  return res.data
}

// ── Code range defaults ───────────────────────────────────────────────────────
// Fetches the first (ASC) and last (DESC) code from the table.
// Returns { first: "ACC001", last: "ZZZ999" }

async function getCodeRange(module) {
  try {
    const res = await api.get(`/lookup/range/${module}`)
    return res.data  // { first, last }
  } catch {
    return { first: '!', last: '~' }  // fallback to original defaults
  }
}

// ── Conversion ───────────────────────────────────────────────────────────────

async function conversionExport(module) {
  const res = await api.get(`/conversion/export/${module}`, { responseType: 'blob' })
  const cd  = res.headers['content-disposition'] || ''
  const match = cd.match(/filename="?([^"]+)"?/)
  const filename = match ? match[1] : `${module}_conversion.xlsx`
  triggerDownload(res.data, filename)
}

async function conversionImport(module, file, emptyTable = false, delimiter = ',', headerLineNo = 1) {
  const form = new FormData()
  form.append('file', file)
  form.append('module', module)
  form.append('emptyTable', emptyTable)
  form.append('delimiter', delimiter)
  form.append('headerLineNo', headerLineNo)
  const res = await api.post('/conversion/import', form, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
  return res.data
}

async function getConversionCount(module) {
  const res = await api.get(`/conversion/count/${module}`)
  return res.data
}

// ── Health ────────────────────────────────────────────────────────────────────

async function checkHealth() {
  try {
    await api.get('/health')
    return true
  } catch {
    return false
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function triggerDownload(blob, filename) {
  const url = URL.createObjectURL(blob)
  const a   = document.createElement('a')
  a.href     = url
  a.download = filename
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
  URL.revokeObjectURL(url)
}

export default {
  exportModule, downloadTemplate, importModule,
  getCodeRange,
  conversionExport, conversionImport, getConversionCount,
  checkHealth
}
