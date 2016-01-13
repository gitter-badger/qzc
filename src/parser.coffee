_ = require './utils/functional'
string = require './utils/string'
lexse = require './lexer'
abs = require './abs/abs'

next = (state) ->
  state.lexems[state.i++]

get = (state) ->
  state.lexems[state.i]

literal = (state) ->
  now = next state

  if string.isNumber now
    abs.Number.parse now
  else if string.isString now
    new abs.String now
  else if string.isCharacter now
    new abs.Character now
  else
    throw new Error 'Unknown lexem, expected Number'

polynom = (state) ->
  result = literal state

  while (get state) in '+-'
    op = next state
    second = literal state

    result = new abs.BinaryOperator op, result, second

  result

expression = (state) ->
  polynom state

parse = (str) ->
  _.types arguments, ['string']

  state =
    lexems: lexse str
    i: 0

  expression state

module.exports = parse
