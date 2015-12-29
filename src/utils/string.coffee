isAlpha = (c) ->
  'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z'

isDigit = (c) ->
  '0' <= c && c <= '9'

isSpace = (c) ->
  c in ' \n\r\t'

isOperator = (c) ->
  c in '!@$%^&*|/\\+=-.~><'

isBreaker = (c) ->
  c in ',()[]{}'

module.exports =
  isAlpha: isAlpha
  isSpace: isSpace
  isDigit: isDigit
  isOperator: isOperator
  isBreaker: isBreaker
