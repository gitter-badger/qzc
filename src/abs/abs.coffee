string = require '../utils/string'

digitToNumber = (digit) ->
  map = {
    '0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5,
    '6': 6, '7': 7, '8': 8, '9': 9, 'a': 10, 'b': 11,
    'c': 12, 'd': 13, 'e': 14, 'f': 15, 'A': 10, 'B': 11,
    'C': 12, 'D': 13, 'E': 14, 'F': 15
  }

  map[digit]

class Integer
  constructor: (@value) ->

Integer.fromDecimal = (str) ->
  val = 0
  for c in str
    val = val * 10 + digitToNumber c
    throw new Error 'Invalid decimal charater ' + c unless string.isDigit(c)

  new Integer val

Integer.fromHex = (str) ->
  val = 0
  for c in str
    val = val * 16 + digitToNumber c
    unless c in '0123456789abcdefABCDEF'
      throw new Error 'Invalid hex charater ' + c

  new Integer val

Integer.fromOct = (str) ->
  val = 0
  for c in str
    val = val * 8 + (+c)
    throw new Error 'Invalid oct charater ' + c unless c in '01234567'

  new Integer val

Integer.fromBin = (str) ->
  val = 0
  for c in str
    val = val * 2 + (+c)
    throw new Error 'Invalid bin charater ' + c unless c in '01'

  new Integer val

class Real
  constructor: (@value) ->

Real.fromDecimal = (str) ->
  point = str.indexOf '.'
  next = str.indexOf('.', point + 1)
  throw new Error 'Multiple points in real literal' if next != -1
  throw new Error 'Bad real number' if point == 0

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

Number.parse = (str) ->
  prefix = str.slice 0, 2

  if prefix == '0x'
    Integer.fromHex str.slice 2
  else if prefix == '0o'
    Integer.fromOct str.slice 2
  else if prefix == '0b'
    Integer.fromBin str.slice 2
  else
    Number.fromDecimal str

class String
  constructor: (value) ->
    [_, middle..., _] = value
    @value = middle.join('')

class Character
  constructor: (value) ->
    [_, middle..., _] = value
    @value = middle.join('')

class BinaryOperator
  constructor: (@op, @first, @second) ->

class UnaryOperator
  constructor: (@op, @argument) ->

module.exports =
  Integer: Integer
  Real: Real
  Number: Number
  String: String
  Character: Character
  BinaryOperator: BinaryOperator
  UnaryOperator: UnaryOperator
