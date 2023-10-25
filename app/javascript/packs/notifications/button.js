import React from 'react'
import PropTypes from 'prop-types'

const Button = ({ handleClick, value }) => {
  const baseClass = `
    bg-purple-500
    focus:outline-none
    focus:shadow-outline
    font-bold
    hover:bg-purple-400
    px-4
    py-2
    rounded
    shadow
    text-white
  `

  return (
    <button className={baseClass} type="button" onClick={handleClick}>
      {value}
    </button>
  )
}

Button.propTypes = {
  handleClick: PropTypes.func,
  value: PropTypes.string
}

export default Button
