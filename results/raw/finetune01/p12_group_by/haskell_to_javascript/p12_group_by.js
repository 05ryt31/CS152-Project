function groupBy(arr, f) {
  var g = {};
  arr.forEach(function(item) {
    var key = f(item);
    if (!g[key]) { g[key] = []; }
    g[key].push(item);
  });
  return g;
}
 
var data = [
  ['a', 1],
  ['b', 3],
  ['a', 5],
  ['c', 7],
  ['b', 9],
];
 
console.log(groupBy(data, function(x) {return x[0];}));
// { 'a': [ [ 'a', 1 ], [ 'a', 5 ] ],
//   'b': [ [ 'b', 3 ], [ 'b', 9 ] ],
//   'c': [ [ 'c', 7 ] ] }
