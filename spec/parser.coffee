chai = require 'chai'
chai.should()

parse = require '../src/parser'

describe 'parse(string)', ->
  describe '#basics', ->
    it 'should to be a function', ->
      parse.should.to.be.a 'function'

    it 'should get one string argument', ->
      chai.expect -> parse ''
        .to.not.throw(Error)

      chai.expect -> parse()
        .to.throw(Error)

      chai.expect -> parse 'first', 'second'
        .to.throw(Error)

      chai.expect -> parse 32
        .to.throw(Error)
