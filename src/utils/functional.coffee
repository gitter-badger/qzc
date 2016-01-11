pair = (x, y) -> [x, y]

zip = (xs, ys) -> zipWith pair, xs, ys

zipWith = (f, xs, ys) ->
  min = Math.min xs.length, ys.length
  [0...min].map (i) -> f xs[i], ys[i]

types = (as, ts) ->
  throw new Error 'Bad arguments count' if as.length != ts.length

  for [a, t] in zip as, ts
    throw new Error('Bad argument ' + a) if typeof a != t

props = (obj) ->
  for k, v of obj then [k, v]

deep = (x, y) ->
  return false if typeof x != typeof y
  type = typeof x

  switch type
    when null, 'undefined' then true
    when 'number', 'string', 'boolean' then x == y
    when 'object'
      px = props(x)
      py = props(y)
      return false unless px.length == py.length

      for [[xk, xv], [yk, yv]] in zip(px, py)
        return false unless deep xk, yk
        return false unless deep xv, yv

      true

module.exports =
  pair: pair
  zip: zip
  zipWith: zipWith
  types: types
  props: props
  deep: deep
