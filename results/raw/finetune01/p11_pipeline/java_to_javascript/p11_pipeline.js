const pipeline = (...funcs) => val => funcs.reduce((a, b) => b(a), val)
 
const add5 = x => x + 5
const mult3 = x => x * 3
const id = x => x
const even = x => x % 2 === 0
const odd = x => x % 2 !== 0
const gt5 = x => x > 5
 
const pipe = pipeline(
  [add5, mult3],
  [id, even, id],
  [id, odd, id],
  [id, gt5, id]
)
 
pipe([1, 2, 3, 4, 5, 6])
// [ 21, 27, 33 ]
 
