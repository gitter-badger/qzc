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

  describe '#identifiers', ->
    it 'should to be splited', ->
      lexse 'one'
        .should.deep.equal ['one', ';']

      lexse 'one    two    three'
        .should.deep.equal ['one', 'two', 'three', ';']

    it 'should accept underscore', ->
      lexse '_123_'
      .should.deep.equal ['_123_', ';']

  describe '#numbers', ->
    it 'should to be splited', ->
      lexse '1'
        .should.deep.equal ['1', ';']

      lexse '111    222    333'
        .should.deep.equal ['111', '222', '333', ';']

      lexse '111.0    222.0f    0xFF'
        .should.deep.equal ['111.0', '222.0f', '0xFF', ';']

  describe '#operators', ->
    it 'should to be splited', ->
      lexse '+='
        .should.deep.equal ['+=', ';']

      lexse '---   ===   |----> ...'
        .should.deep.equal ['---', '===', '|---->', '...', ';']

  describe '#breakers', ->
    it 'should to be splited', ->
      lexse '()'
        .should.deep.equal ['(', ')', ';']

      lexse '{([])}'
        .should.deep.equal ['{', '(', '[', ']', ')', '}', ';']

    it 'comma should be a spliter', ->
      lexse ',,,'
        .should.deep.equal [',', ',', ',', ';']

  describe '#literals', ->
    it '#strings', ->
      lexse '"Some string"'
        .should.deep.equal ['"Some string"', ';']

      lexse '"Some string" "some string"'
        .should.deep.equal ['"Some string"', '"some string"', ';']

      lexse 'prefixed"Some string"'
        .should.deep.equal ['prefixed', '"Some string"', ';']

    it '#characters', ->
      lexse "'some char'"
        .should.deep.equal ["'some char'", ';']

      lexse "'a' 'b' 'c'"
        .should.deep.equal ["'a'", "'b'", "'c'", ';']

      lexse "prefixed'a'"
        .should.deep.equal ['prefixed', "'a'", ';']

    it '#comments', ->
      lexse '# some oneline comment'
        .should.deep.equal [';']

      lexse 'x y z # comment'
        .should.deep.equal ['x', 'y', 'z', ';']

    it '#multiline comments', ->
      lexse 'x #{ some multiline comment } y'
        .should.deep.equal ['x', 'y', ';']

      lexse 'x #{ some\n\rmultiline\n\rcomment } y'
        .should.deep.equal ['x', 'y', ';']

  describe '#indents', ->
    it '#must split one-indent lines', ->
      lexse("""
        x = 1
        y = 2
      """).should.deep.equal ['x', '=', '1', ';', 'y', '=', '2', ';']

    it '#must concat add-indent lines', ->
      lexse("""
        x = ->
         foo
      """).should.deep.equal ['x', '=', '->', '(', 'foo', ')', ';']

    it '#must work well with multiline definitions', ->
      lexse("""
        foo = x ->
         console.log 'Hello'
         console.log 'World!'
      """).should.deep.equal [
        'foo', '=', 'x', '->', '(',
          'console', '.', 'log', "'Hello'", ';',
          'console', '.', 'log', "'World!'",
        ')', ';'
      ]

    it '#must work well with arrays', ->
      lexse("""
        [1, 2, 3]
      """).should.deep.equal ['[', '1', ',', '2', ',', '3', ']', ';']

      lexse("""
        [
         1, 2, 3
        ]
      """).should.deep.equal ['[', '1', ',', '2', ',', '3', ';', ']', ';']

      lexse("""
        [
         1
         2
         3
        ]
      """).should.deep.equal ['[', '1', ';', '2', ';', '3', ';', ']', ';']
