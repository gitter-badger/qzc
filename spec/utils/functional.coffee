chai = require 'chai'
chai.should()

_ = require '../../src/utils/functional'

describe 'functional', ->
  describe '#pair(x, y)', ->
    it 'should make pair', ->
      _.pair 1, 2
        .should.be.deep.equal [1, 2]

      _.pair 'some', 'value'
        .should.be.deep.equal ['some', 'value']

  describe '#zip(xs, ys)', ->
    it 'should zip arrays', ->
      _.zip [1, 2, 3], [3, 4, 5]
        .should.be.deep.equal [[1, 3], [2, 4], [3, 5]]

    it 'should cut by minimal array', ->
      _.zip [1, 2, 3], [3]
        .should.be.deep.equal [[1, 3]]

      _.zip [1], [3, 4, 5]
        .should.be.deep.equal [[1, 3]]

    it 'should return empty if one of arguments is empty', ->
      _.zip [1, 2, 3], []
        .should.be.deep.equal []

      _.zip [], [3, 4, 5]
        .should.be.deep.equal []

  describe '#zipWith', ->
    plus = (a, b) -> a + b

    it 'should zip arrays', ->
      _.zipWith plus, [1, 2, 3], [3, 4, 5]
      .should.be.deep.equal [4, 6, 8]

    it 'should cut by minimal array', ->
      _.zipWith plus, [1, 2, 3], [3]
      .should.be.deep.equal [4]

      _.zipWith plus, [1], [3, 4, 5]
      .should.be.deep.equal [4]

    it 'should return empty if one of arguments is empty', ->
      _.zipWith plus, [1, 2, 3], []
      .should.be.deep.equal []

      _.zipWith plus, [], [3, 4, 5]
      .should.be.deep.equal []

  describe '#types', ->
    it 'should pass if types equal', ->
      chai.expect -> _.types ['str', 1, -> null], ['string', 'number', 'function']
        .to.not.throw(Error)

    it 'should not pass if types count not equal', ->
      chai.expect -> _.types ['str', 1], ['string', 'number', 'function']
        .to.throw(Error)

      chai.expect -> _.types ['str', 1, -> null], ['string', 'number']
        .to.throw(Error)

    it 'should not pass if types not equal', ->
      chai.expect -> _.types ['str', 1, -> null], ['number', 'number', 'function']
        .to.throw(Error)

      chai.expect -> _.types ['str', 1, -> null], ['string', 'number', 'number']
        .to.throw(Error)

    it 'should not pass if arguments order wrong', ->
      chai.expect -> _.types ['str', 1, -> null], ['number', 'string', 'function']
        .to.throw(Error)

      chai.expect -> _.types ['str', 1, -> null], ['string', 'function', 'number']
        .to.throw(Error)

  describe '#deep', ->
    it 'should return true on same objects', ->
      _.deep([1, 2, 3], [1, 2, 3]).should.be.equal true
      _.deep({x: 1, y: 2}, {x: 1, y: 2}).should.be.equal true

    it 'should return false on different objects', ->
      _.deep([1, 2, 3], [1, 2, 4]).should.be.equal false
      _.deep({x: 1, y: 2}, {x: 1, y: 3}).should.be.equal false
      _.deep({x: 1, y: 2}, {x: 1, z: 2}).should.be.equal false

    it 'should return false on different sub-objects', ->
      _.deep([{}, {}, {}], [{}, {}, {}]).should.be.equal true
      _.deep({x: [1,2,3], y: [2,3,4]}, {x: [1,2,3], y: [2,3,4]})
