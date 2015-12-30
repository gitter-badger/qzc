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
