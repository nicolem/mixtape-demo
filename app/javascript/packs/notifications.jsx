import React from 'react'
import * as ReactDOM from 'react-dom/client'
import PropTypes from 'prop-types'

import New from './notifications/new'

document.addEventListener('DOMContentLoaded', () => {
  const root = ReactDOM.createRoot(
    document.body.appendChild(document.createElement('div'))
  )

  root.render(<New />)
})
