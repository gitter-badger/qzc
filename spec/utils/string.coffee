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
