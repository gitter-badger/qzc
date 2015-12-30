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

isNumber = (str) ->
  point = str.indexOf '.'
  return false if point == 0
  return false if str.indexOf('.', point + 1) != -1

  for c in str
    continue if c == '.'
    return false unless isDigit c

  true

module.exports =
  isAlpha: isAlpha
  isSpace: isSpace
  isDigit: isDigit
  isOperator: isOperator
  isBreaker: isBreaker
  isNumber: isNumber
