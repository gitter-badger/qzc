isAlpha = (c) ->
  'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z'

isDigit = (c) ->
  '0' <= c && c <= '9'

isSpace = (c) ->
  c in ' \n\r\t'

module.exports =
  isAlpha: isAlpha
  isSpace: isSpace
  isDigit: isDigit
