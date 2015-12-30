_ = require './utils/functional'
lexse = require './lexer'
abs = require './abs/abs'

parse = (str) ->
  _.types arguments, ['string']
  lexems = lexse str

  return new abs.Integer.fromDecimal lexems[0]

module.exports = parse
