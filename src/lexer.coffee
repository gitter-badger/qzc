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

matchNumber = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i]) || s.str[s.i] == '.'
    result += s.str[s.i]
    s.i += 1

  s.tokens.push(result)

matchOperator = (s) ->
  result = ''

  while string.isOperator(s.str[s.i])
    result += s.str[s.i]
    s.i += 1

  s.tokens.push(result)

matchBreaker = (s) ->
  result = s.str[s.i]
  s.tokens.push(result)

  s.i += 1

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
    else if string.isDigit(c)
      matchNumber(state)
    else if string.isOperator(c)
      matchOperator(state)
    else if string.isBreaker(c)
      matchBreaker(state)
    else
      throw new Error 'Unknown character ' + c

  state.tokens

module.exports = lexse
