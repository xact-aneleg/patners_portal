import axios from 'axios'

// Dynamically resolve backend host — works from any device on the network
const BASE = `${window.location.protocol}//${window.location.hostname}:8080/api`

const http = axios.create({ baseURL: BASE })

const api = {
  checkHealth: () => http.get('/health').then(() => true).catch(() => false),

  exportModule: (module, filters) =>
    http.post(`/export/${module}`, filters, { responseType: 'blob' }).then(r => r.data),

  downloadTemplate: (module) =>
    http.get(`/export/${module}/template`, { responseType: 'blob' }).then(r => r.data),

  importModule: (module, file) => {
    const form = new FormData()
    form.append('file', file)
    return http.post(`/import/${module}`, form).then(r => r.data)
  },

  conversionExport: (module) =>
    http.get(`/conversion/export/${module}`, { responseType: 'blob' }).then(r => r.data),

  conversionImport: (file, module, emptyTable = false) => {
    const form = new FormData()
    form.append('file', file)
    return http.post(`/conversion/import?module=${module}&emptyTable=${emptyTable}`, form).then(r => r.data)
  },

  getCount: (module) =>
    http.get(`/conversion/count/${module}`).then(r => r.data),

  lookup: (module, q, limit = 15) =>
    http.get(`/lookup/${module}`, { params: { q, limit } }).then(r => r.data),

  getCodeRange: (module) =>
    http.get(`/lookup/range/${module}`).then(r => r.data),
}

export default api
