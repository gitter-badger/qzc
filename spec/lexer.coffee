chai = require 'chai'
chai.should()

lexse = require '../src/lexer'

describe 'lexse(string)', ->
  describe '#basics', ->
    it 'should to be a function', ->
      lexse.should.to.be.a 'function'

    it 'should get one string argument', ->
      chai.expect -> lexse ''
        .to.not.throw(Error)

      chai.expect -> lexse()
        .to.throw(Error)

      chai.expect -> lexse 'first', 'second'
        .to.throw(Error)

      chai.expect -> lexse 32
        .to.throw(Error)
