string = require '../utils/string'

class Integer
  constructor: (@value) ->

Integer.fromDecimal = (str) ->
  val = 0
  for c in str
    val = val * 10 + (+c)
    throw new Error 'Invalid decimal charater ' + c unless string.isDigit(c)

  new Integer val

class Real
  constructor: (@value) ->

Real.fromDecimal = (str) ->
  point = str.indexOf '.'
  throw new Error 'Multiple points in real literal' if str.indexOf('.', point + 1) != -1

  val = 0
  for c in str
    continue if c == '.'
    val = val * 10 + (+c)
    throw new Error 'Invalid decimal charater ' + c unless string.isDigit(c)

  val /= Math.pow(10, str.length - point - 1)

  new Real val

class Number
Number.fromDecimal = (str) ->
  (if '.' in str
    Real
  else
    Integer
  ).fromDecimal str

module.exports =
  Integer: Integer
  Real: Real
  Number: Number
