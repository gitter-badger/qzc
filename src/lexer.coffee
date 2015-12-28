lexse = (str) ->
  throw new Error 'Bad arguments count' if arguments.length != 1
  throw new Error 'Bad argument type' if typeof str != 'string'

module.exports = lexse
