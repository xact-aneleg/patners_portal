import axios from 'axios'

// Direct backend URL — works from any device on the network
function getBase() {
  const host = window.location.hostname
  return `${window.location.protocol}//${host}:8080/api/portal`
}

function makeHttp() {
  const http = axios.create({ baseURL: getBase() })
  http.interceptors.request.use(cfg => {
    const token = localStorage.getItem('pp_token')
    if (token) cfg.headers.Authorization = `Bearer ${token}`
    return cfg
  })
  http.interceptors.response.use(
    r => r,
    err => {
      console.error('API error:', err.response?.status, err.response?.data, err.config?.url)
      return Promise.reject(err)
    }
  )
  return http
}

// Create fresh http instance each call so baseURL is always current
const http = () => makeHttp()

export async function login(email, password) {
  const res = await http().post('/auth/login', { email, password })
  localStorage.setItem('pp_token',    res.data.token)
  localStorage.setItem('pp_role',     res.data.role)
  localStorage.setItem('pp_name',     res.data.name)
  localStorage.setItem('pp_pid',      String(res.data.partnerId))
  return res.data
}

export async function registerPartner(data) {
  const res = await http().post('/auth/register', data)
  localStorage.setItem('pp_token',    res.data.token)
  localStorage.setItem('pp_role',     res.data.role)
  localStorage.setItem('pp_name',     res.data.name)
  localStorage.setItem('pp_pid',      String(res.data.partnerId))
  return res.data
}

export function logout() {
  ['pp_token','pp_role','pp_name','pp_pid'].forEach(k => localStorage.removeItem(k))
  // Note: we keep pp_avatar in localStorage so it persists across sessions
}

export function getSession() {
  const token = localStorage.getItem('pp_token')
  if (!token) return null
  return {
    token,
    role:      localStorage.getItem('pp_role'),
    name:      localStorage.getItem('pp_name'),
    partnerId: localStorage.getItem('pp_pid'),
  }
}

export const listMyRegistrations = ()      => http().get('/registrations').then(r => r.data)
export const getRegistration     = id      => http().get(`/registrations/${id}`).then(r => r.data)
export const createRegistration  = data    => http().post('/registrations', data).then(r => r.data)
export const updateRegistration  = (id, d) => http().put(`/registrations/${id}`, d).then(r => r.data)
export const submitRegistration  = id      => http().post(`/registrations/${id}/submit`).then(r => r.data)
export const approveImply        = (id, c) => http().post(`/registrations/${id}/approve-imply`, { comments: c }).then(r => r.data)
export const declineImply        = (id, c) => http().post(`/registrations/${id}/decline-imply`, { comments: c }).then(r => r.data)
export const approveXact         = (id, c) => http().post(`/registrations/${id}/approve-xact`,  { comments: c }).then(r => r.data)
export const declineXact         = (id, c) => http().post(`/registrations/${id}/decline-xact`,  { comments: c }).then(r => r.data)
export const triggerConversion   = id      => http().post(`/registrations/${id}/convert`).then(r => r.data)
export const getConversionStatus = id      => http().get(`/registrations/${id}/conversion-status`).then(r => r.data)
export const getAllRegistrations  = ()      => http().get('/admin/registrations').then(r => r.data)
export const getPendingXact      = ()      => http().get('/admin/pending-xact').then(r => r.data)
export const getPendingImply     = ()      => http().get('/admin/pending-imply').then(r => r.data)
