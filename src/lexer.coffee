_ = require './utils/functional'
string = require './utils/string'

matchSpace = (s) ->
  while string.isSpace(s.str[s.i])
    s.i += 1

matchIdentifier = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i])
    result += s.str[s.i]
    s.i += 1

  s.tokens.push(result)

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
    else if string.isAlpha(c)
      matchIdentifier(state)
    else
      throw new Error 'Unknown character ' + c

  state.tokens

module.exports = lexse
