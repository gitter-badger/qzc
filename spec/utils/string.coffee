chai = require 'chai'
chai.should()

string = require '../../src/utils/string'

describe 'string', ->
  describe '#isAlpha(char)', ->
    it 'should be true for latin alphas', ->
      for c in 'abcABCedzEDZ'
        string.isAlpha(c).should.be.equal true

    it 'should be false for non latin alphas', ->
      for c in 'абвАБВгдяГДЯ'
        string.isAlpha(c).should.be.equal false

    it 'should be false for non alphas', ->
      for c in '123!@# \n\t'
        string.isAlpha(c).should.be.equal false

  describe '#isSpace(char)', ->
    it 'should be true for whitespaces', ->
      for c in ' \t\n\r'
        string.isSpace(c).should.be.equal true

    it 'should be false for non whitespaces', ->
      for c in 'abcdeABCDExyzXYZ123!@#'
        string.isSpace(c).should.be.equal false

  describe '#isDigit(char)', ->
    it 'should be true for digits', ->
      for c in '0123456789'
        string.isDigit(c).should.be.equal true

    it 'should be false for non digits', ->
      for c in 'abcdeABCDExyzXYZ!@# \t\r\n'
        string.isDigit(c).should.be.equal false

  describe '#isOperator(char)', ->
    it 'should be true for operators', ->
      for c in '!@$%^&*|/\\+=-.~><:?'
        string.isOperator(c).should.be.equal true

    it 'should be false for non digits', ->
      for c in '(){}[]123abc,;'
        string.isOperator(c).should.be.equal false

  describe '#isBreaker(char)', ->
    it 'should be true for operators', ->
      for c in '(){}[],;'
        string.isBreaker(c).should.be.equal true

    it 'should be false for non digits', ->
      for c in '!@$%^&*|/\\+=-.~><123abc:?'
        string.isBreaker(c).should.be.equal false

  describe '#isNumber(str)', ->
    it 'should be true for decimal integer and real numbers', ->
      for n in ['0', '1', '15', '50.1', '12.121', '12321.']
        string.isNumber(n).should.be.equal true

    it 'should be false for bad integer and real numbers', ->
      for n in ['', 'a', '0d', '50..1', '12.12.1', '.12321']
        string.isNumber(n).should.be.equal false

    it 'should be true for hexademical', ->
      for n in ['0x0', '0xAB0', '0xef2']
        string.isNumber(n).should.be.equal true

    it 'should be false for bad hexademical', ->
      for n in ['0x', '0xxx']
        string.isNumber(n).should.be.equal false

    it 'should be true for oct', ->
      for n in ['0o0', '0o76543210']
        string.isNumber(n).should.be.equal true

    it 'should be false for bad oct', ->
      for n in ['0o', '0o8', '0oa']
        string.isNumber(n).should.be.equal false

    it 'should be true for bin', ->
      for n in ['0b0', '0b01010101']
        string.isNumber(n).should.be.equal true

    it 'should be false for bad bin', ->
      for n in ['0b', '0b2', '0bB']
        string.isNumber(n).should.be.equal false

  describe '#findAll(str)', ->
    it 'should return empty array if there no elements', ->
      string.findAll('#', '123456asd').should.be.deep.equal []

    it 'should return indexes if there are some elements', ->
      string.findAll('#', '#123#567#').should.be.deep.equal [0, 4, 8]
