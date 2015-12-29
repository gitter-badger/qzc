isAlpha = (c) ->
  'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z'

isSpace = (c) ->
  c in ' \n\r\t'

module.exports =
  isAlpha: isAlpha
  isSpace: isSpace
