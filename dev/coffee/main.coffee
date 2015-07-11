#main js
'use strict'

getThisyear = ->
  dt = new Date()
  return dt.getFullYear().toString()

$('#thisyear').text(getThisyear())
