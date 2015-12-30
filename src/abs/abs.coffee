string = require '../utils/string'

class Integer
  constructor: (@value) ->

Integer.fromDecimal = (str) ->
  val = 0
  for c in str
    throw new Error 'Invalid decimal charater ' + c unless string.isDigit(c)
    val *= 10
    val += +c

  new Integer val

module.exports =
  Integer: Integer
