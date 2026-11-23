const groupBy = (array, property) => array.reduce((acc, item) => {
  const key = item[property];
  acc[key] = [...(acc[key] || []), item];
  return acc;
}, {});
 
// Example usage:
const data = [
  { name: 'Alice', age: 21 },
  { name: 'Max', age: 20 },
  { name: 'Eva', age: 20 },
  { name: 'Mia', age: 22 },
  { name: 'Leo', age: 20 },
];
 
console.log(groupBy(data, 'age'));
// Output:
// {
//   20: [
//     { name: 'Max', age: 20 },
//     { name: 'Eva', age: 20 },
//     { name: 'Leo', age: 20 },
//   ],
//   21: [ { name: 'Alice', age: 21 } ],
//   22: [ { name: 'Mia', age: 22 } ],
// }
