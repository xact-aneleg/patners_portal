import React from 'react'
import s from './StatusPill.module.css'

const MAP = {
  DRAFT:          { label: 'Draft',               cls: 'draft'    },
  PENDING_IMPLY:  { label: 'Pending Imply',        cls: 'imply'    },
  PENDING_XACT:   { label: 'Pending XactERP',      cls: 'xact'     },
  APPROVED:       { label: 'Approved',             cls: 'approved' },
  DECLINED_IMPLY: { label: 'Declined by Imply',    cls: 'declined' },
  DECLINED_XACT:  { label: 'Declined by XactERP',  cls: 'declined' },
  CONVERTING:     { label: 'Converting',           cls: 'convert'  },
  LIVE:           { label: 'Live',                 cls: 'live'     },
}

export default function StatusPill({ status }) {
  const { label, cls } = MAP[status] || { label: status, cls: 'draft' }
  return <span className={`${s.pill} ${s[cls]}`}>{label}</span>
}
