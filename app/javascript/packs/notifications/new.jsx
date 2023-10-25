import React, { useState } from 'react'
import axios from 'axios'

import Button from './button'
import Label from './label'
import TextInput from './text-input'

const New = props => {
  const [artist, setArtist] = useState('')
  const [phoneNumber, setPhone] = useState('')

  const submitForm = async () => {
    try {
      const response = await axios.post('/notification', {
        notification: {
          artist,
          phoneNumber
        }
      })

      console.log(response)
    } catch (error) {
      console.log(error)
    }
  }

  return (
    <div className="mx-auto my-10 w-2/4 p-10 border border-gray-500 rounded">
      <h1 className="text-center text-2xl mb-5">Mixtape</h1>

      <div className="flex items-center mb-5">
        <div className="w-1/3">
          <Label labelFor="artist" value="Artist" />
        </div>

        <div className="w-2/3">
          <TextInput id="artist" handleChange={setArtist} value={artist} />
        </div>
      </div>

      <div className="flex items-center mb-5">
        <div className="w-1/3">
          <Label labelFor="phone" value="Phone Number" />
        </div>

        <div className="w-2/3">
          <TextInput id="phone" handleChange={setPhone} value={phoneNumber} />
        </div>
      </div>

      <div className="flex items-center">
        <div className="w-1/3"></div>
        <div className="w-2/3">
          <Button handleClick={submitForm} value="Submit" />
        </div>
      </div>
    </div>
  )
}

export default New
