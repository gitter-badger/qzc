# TODO: Move to utils
pair = (x, y) -> [x, y]

zip = (xs, ys) -> zipWith pair, xs, ys

zipWith = (f, xs, ys) ->
  min = Math.min xs.length, ys.length
  [0...min].map (i) -> f xs[i], ys[i]

types = (as, ts) ->
  throw new Error 'Bad arguments count' if as.length != ts.length

  for [a, t] in zip as, ts
    throw new Error('Bad argument ' + a) if typeof a != t

lexse = (str) ->
  types arguments, ['string']

module.exports = lexse
