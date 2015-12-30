_ = require './utils/functional'
string = require './utils/string'
lexse = require './lexer'
abs = require './abs/abs'

parse = (str) ->
  _.types arguments, ['string']
  lexems = lexse str

  if string.isNumber lexems[0]
    return new abs.Number.parse lexems[0]
  else
    throw new Error 'Unknown lexem, expected Number'

module.exports = parse
