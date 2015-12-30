_ = require './utils/functional'
lexse = require './lexer'

parse = (str) ->
  _.types arguments, ['string']
  lexems = lexse str

module.exports = parse
