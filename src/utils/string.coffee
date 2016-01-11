_ = require './functional'

findAll = (c, str) ->
  result = []
  for e, i in str
    if e == c
      result.push i

  result

isAlpha = (c) ->
  'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z'

isDigit = (c) ->
  '0' <= c && c <= '9'

isSpace = (c) ->
  c in ' \n\r\t'

isOperator = (c) ->
  c in '!@$%^&*|/\\+=-.~><:?'

isBreaker = (c) ->
  c in ',;()[]{}'

isUnderscore = (c) ->
  c == '_'

isDot = (c) ->
  c == '.'

isIndentPart = (c) ->
  isAlpha(c) || isDigit(c) || isUnderscore(c)

isNumberPart = (c) ->
  isAlpha(c) || isDigit(c) || isDot(c)

isDecimal = (str) ->
  point = str.indexOf '.'
  return false if point == 0
  return false if str.indexOf('.', point + 1) != -1

  for c in str
    continue if c == '.'
    return false unless isDigit c

  true

isHex = (str) ->
  return false if str.length == 0

  for c in str
    return false unless isDigit(c) || c in 'abcdefABCDEF'

  true

isOct = (str) ->
  return false if str.length == 0

  for c in str
    return false unless c in '01234567'

  true

isBin = (str) ->
  return false if str.length == 0

  for c in str
    return false unless c in '01'

  true

isNumber = (str) ->
  return false if str.length == 0
  prefix = str.slice 0, 2

  if prefix == '0x'
    isHex str.slice 2
  else if prefix == '0o'
    isOct str.slice 2
  else if prefix == '0b'
    isBin str.slice 2
  else
    isDecimal str

isString = (str) ->
  return false if str.length < 2
  indexes = findAll '"', str

  _.deep indexes, [0, str.length - 1]

isCharacter = (str) ->
  return false if str.length < 2
  indexes = findAll "'", str

  _.deep indexes, [0, str.length - 1]

module.exports =
  findAll: findAll
  isAlpha: isAlpha
  isSpace: isSpace
  isDigit: isDigit
  isOperator: isOperator
  isBreaker: isBreaker
  isIndentPart: isIndentPart
  isNumberPart: isNumberPart
  isNumber: isNumber
  isString: isString
  isCharacter: isCharacter
