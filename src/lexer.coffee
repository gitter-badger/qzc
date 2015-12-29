_ = require './utils/functional'
string = require './utils/string'

popChar = (s) ->
  throw new Error 'Unexpected file end' if s.i >= s.str.length
  s.str[s.i++]

matchSpace = (s) ->
  while string.isSpace(s.str[s.i])
    s.i += 1

matchIdentifier = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i]) || s.str[s.i] == '_'
    result += popChar(s)

  s.tokens.push(result)

matchNumber = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i]) || s.str[s.i] == '.'
    result += popChar(s)

  s.tokens.push(result)

matchOperator = (s) ->
  result = ''

  while string.isOperator(s.str[s.i])
    result += popChar(s)

  s.tokens.push(result)

matchBreaker = (s) ->
  result = popChar(s)
  s.tokens.push(result)

matchString = (s) ->
  result = popChar(s)

  while s.str[s.i] != '"'
    result += popChar(s)

  result += popChar(s)

  s.tokens.push(result)

matchChar = (s) ->
  result = popChar(s)

  while s.str[s.i] != "'"
    result += popChar(s)

  result += popChar(s)

  s.tokens.push(result)

matchLineComment = (s) ->
  while s.i < s.str.length && s.str[s.i] != '\n' && s.str[s.i] != "\r"
    popChar(s)

lexse = (str) ->
  _.types arguments, ['string']

  state =
    str: str
    i: 0
    tokens: []

  while state.i < str.length
    c = state.str[state.i]
    if string.isSpace(c)
      matchSpace(state)
    else if string.isAlpha(c) || c == '_'
      matchIdentifier(state)
    else if string.isDigit(c)
      matchNumber(state)
    else if string.isOperator(c)
      matchOperator(state)
    else if string.isBreaker(c)
      matchBreaker(state)
    else if c == '"'
      matchString(state)
    else if c == "'"
      matchChar(state)
    else if c == "#"
      matchLineComment(state)
    else
      throw new Error 'Unknown character ' + c

  state.tokens

module.exports = lexse
