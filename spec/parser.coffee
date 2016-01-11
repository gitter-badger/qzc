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
            val.should.be.deep.equal abs.Integer.fromDecimal i
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
            val.should.be.deep.equal abs.Real.fromDecimal d
            val.should.be.not.deep.equal new abs.Real 12.2
            val.value.should.be.equal parseFloat d

        it 'should throw error on incorrect real numbers', ->
          for d in ['150.d', '.12.2', '15.1.2', '123d.123']
            chai.expect -> parse d
              .to.throw Error

      describe '#hex', ->
        it 'should parse correct hex', ->
          for h in ['0xff', '0x123', '0x321', '0x543534']
            val = parse h
            val.should.be.deep.equal abs.Number.parse h
            val.should.be.not.deep.equal new abs.Integer 666
            val.value.should.be.equal parseInt (h.slice 2), 16

        it 'should throw error on incorrect hex', ->
          for h in ['0x', '0xFX', '0x2.3', '0xxx']
            chai.expect -> parse h
              .to.throw Error

      describe '#oct', ->
        it 'should parse correct oct', ->
          for o in ['0o0', '0o777', '0o1234', '0o01234567']
            val = parse o
            val.should.be.deep.equal abs.Number.parse o
            val.should.be.not.deep.equal new abs.Integer 666
            val.value.should.be.equal parseInt (o.slice 2), 8

        it 'should throw error on incorrect oct', ->
          for o in ['0o', '0ox', '0o8']
            chai.expect -> parse o
              .to.throw Error

      describe '#bin', ->
        it 'should parse correct bin', ->
          for b in ['0b0', '0b01010101']
            val = parse b
            val.should.be.deep.equal abs.Number.parse b
            val.should.be.not.deep.equal new abs.Integer 666
            val.value.should.be.equal parseInt (b.slice 2), 2

        it 'should throw error on incorrect bin', ->
          for b in ['0b', '0b2', '0bX']
            chai.expect -> parse b
              .to.throw Error

      describe '#strings', ->
        it 'should parse correct strings', ->
          for s in ['"correct string"', '"another string"']
            val = parse s
            val.should.be.deep.equal new abs.String s

        it 'should thows error on incorrect strings', ->
          for s in ['"unclosed string', 'unopened string"', '"string with " extra quote"']
            chai.expect -> parse s
              .to.throw Error

        it 'value should be unqouted', ->
          parse('"string"').value.should.be.equal 'string'

      describe '#characters', ->
        it 'should parse correct characters', ->
          for c in ["'c'", "'correct'"]
            val = parse c
            val.should.be.deep.equal new abs.Character c

        it 'should thows error on incorrect characters', ->
          for c in ["'unc", "unop'", "'ex'ra'"]
            chai.expect -> parse c
              .to.throw Error

        it 'value should be unqouted', ->
          parse("'c'").value.should.be.equal 'c'
