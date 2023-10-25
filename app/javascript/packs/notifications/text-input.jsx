import React from 'react'
import PropTypes from 'prop-types'

const TextInput = ({ id, handleChange, value }) => {
  const baseClass = `
    appearance-none
    bg-gray-200
    border-2
    border-gray-200
    focus:bg-white
    focus:border-purple-500
    focus:outline-none
    leading-tight
    px-4
    py-2
    rounded
    text-gray-700
    w-full
  `

  return (
    <input
      id={id}
      type="text"
      className={baseClass}
      value={value}
      onChange={e => handleChange(e.target.value)}
    />
  )
}

TextInput.propTypes = {
  id: PropTypes.string,
  handleChange: PropTypes.func,
  value: PropTypes.string
}

export default TextInput
