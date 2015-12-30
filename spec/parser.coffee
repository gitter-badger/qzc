chai = require 'chai'
chai.should()

parse = require '../src/parser'
abs = require '../src/abs/abs'

describe 'parse(string)', ->
  describe '#basics', ->
    it 'should to be a function', ->
      parse.should.to.be.a 'function'

    it 'should get one string argument', ->
      chai.expect -> parse '1'
        .to.not.throw(Error)

      chai.expect -> parse()
        .to.throw(Error)

      chai.expect -> parse 'first', 'second'
        .to.throw(Error)

      chai.expect -> parse 32
        .to.throw(Error)

  describe '#literals', ->
    describe '#numbers', ->
      describe '#integer', ->
        it 'should parse correct integers', ->
          for i in ['150', '1000', '6127321637238216', '0']
            val = parse i
            val.should.be.deep.equal new abs.Integer.fromDecimal i
            val.should.be.not.deep.equal new abs.Integer 666
            val.value.should.be.equal parseInt i

        it 'should throw error on incorrect integers', ->
          for i in ['150d', '1000SSsss', '6127321637238216DSADasDasds', '0xxx']
            chai.expect -> parse i
              .to.throw Error

      describe '#real', ->
        it 'should parse correct real numbers', ->
          for d in ['12.1', '5.2', '3.333', '0.1', '12.']
            val = parse d
            val.should.be.deep.equal new abs.Real.fromDecimal d
            val.should.be.not.deep.equal new abs.Real 12.2
            val.value.should.be.equal parseFloat d

        it 'should throw error on incorrect real numbers', ->
          for d in ['150.d', '12..2', '15.1.2', '123d.123']
            chai.expect -> parse d
              .to.throw Error
