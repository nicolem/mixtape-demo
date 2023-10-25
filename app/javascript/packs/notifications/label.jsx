import React from 'react'
import PropTypes from 'prop-types'

const Label = ({ labelFor, value }) => {
  const baseClass = `
    block
    font-bold
    mb-1
    md:mb-0
    md:text-right
    pr-4
    text-gray-500
  `

  return (
    <label htmlFor={labelFor} className={baseClass}>
      {value}
    </label>
  )
}

Label.propTypes = {
  labelFor: PropTypes.string,
  value: PropTypes.string
}

export default Label
