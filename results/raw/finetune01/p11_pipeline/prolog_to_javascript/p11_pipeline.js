const pipeline = (...funcs) => val => funcs.reduce((a, b) => b(a), val);
 
const add5 = x => x + 5;
const mul3 = x => x * 3;
const even = x => x % 2 === 0;
const odd = x => x % 2 !== 0;
const gt5 = x => x > 5;
 
const pipe = pipeline(
    add5,
    mul3,
    even,
    odd,
    gt5
);
 
pipe(4); // false
pipe(7); // true
