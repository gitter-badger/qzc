_ = require './utils/functional'
string = require './utils/string'

popChar = (s) ->
  throw new Error 'Unexpected file end' if s.i >= s.str.length
  s.str[s.i++]

endContext = (s) ->
  context = s.contexts[s.contexts.length - 1]
  if context in '{[('
    s.tokens.push ','
  else
    s.tokens.push ';'

skipChar = (s, c) ->
  popChar s if s.str[s.i] == c

matchSpace = (s) ->
  while string.isSpace s.str[s.i]
    s.i++
    processIndent s if s.str[s.i - 1] == '\n'

matchIdentifier = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i]) || s.str[s.i] == '_'
    result += popChar s

  s.tokens.push result

matchNumber = (s) ->
  result = ''

  while string.isAlpha(s.str[s.i]) || string.isDigit(s.str[s.i]) || s.str[s.i] == '.'
    if (s.str[s.i] == '.') && (s.str[s.i - 1] == '.')
      s.i -= 1
      result = result.slice(0, result.length - 1)
      break

    result += popChar s

  s.tokens.push result

matchOperator = (s) ->
  result = ''

  while string.isOperator s.str[s.i]
    result += popChar s

  s.tokens.push result

matchBreaker = (s) ->
  result = popChar s
  s.tokens.push result

matchString = (s) ->
  result = popChar s

  while s.str[s.i] != '"'
    result += popChar s

  result += popChar s

  s.tokens.push result

matchChar = (s) ->
  result = popChar s

  while s.str[s.i] != "'"
    result += popChar s

  result += popChar s

  s.tokens.push result

matchComment = (s) ->
  popChar s

  end = if s.str[s.i] == '{'
    '}'
  else
    '\r\n'

  while s.i < s.str.length && s.str[s.i] not in end
    popChar s

  skipChar s, '}' if end == '}'

preprocess = (str) ->
  str.split('\n').filter((s)-> s.trim().length != 0).join('\n') + '\n'

processIndent = (s, mode) ->
  s.lastIndent = s.indent
  s.indent = 0

  while s.str[s.i] in ' \t'
    s.indent++
    s.i++

  lastToken = s.tokens[s.tokens.length - 1]
  nextToken = s.str[s.i]

  if s.indent > s.lastIndent
    delta = s.indent - s.lastIndent

    for x in [0...delta]
      s.contexts.push lastToken

    if lastToken not in '[{('
      for x in [0...delta]
        s.tokens.push '('
  else if s.indent < s.lastIndent
    delta = s.lastIndent - s.indent

    for x in [0...delta]
      context = s.contexts.pop()
      s.tokens.pop() if s.tokens[s.tokens.length - 1] in ',;'

      if context not in '[{('
        s.tokens.push ')'
        endContext s
  else if mode not in ['start', 'end'] && lastToken not in '[{(' && nextToken not in ']})'
    endContext s

lexse = (str) ->
  _.types arguments, ['string']

  str = preprocess str

  state =
    contexts: []
    lastIndent: 0
    indent: 0
    str: str
    i: 0
    tokens: []

  processIndent state, 'start'
  while state.i < str.length
    c = state.str[state.i]

    if string.isSpace c
      matchSpace state
    else if string.isAlpha(c) || c == '_'
      matchIdentifier state
    else if string.isDigit c
      matchNumber state
    else if string.isOperator c
      matchOperator state
    else if string.isBreaker c
      matchBreaker state
    else if c == '"'
      matchString state
    else if c == "'"
      matchChar state
    else if c == "#"
      matchComment state
    else
      throw new Error 'Unknown character ' + c

  state.tokens

module.exports = lexse
