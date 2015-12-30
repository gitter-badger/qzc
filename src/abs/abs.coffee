string = require '../utils/string'

class Integer
  constructor: (@value) ->

Integer.fromDecimal = (str) ->
  val = 0
  for c in str
    val = val * 10 + (+c)
    throw new Error 'Invalid decimal charater ' + c unless string.isDigit(c)

  new Integer val

module.exports =
  Integer: Integer
