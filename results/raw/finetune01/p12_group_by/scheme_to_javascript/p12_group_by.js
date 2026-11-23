function groupBy(array, func) {
    var grouped = {};
 
    array.forEach(function(item) {
        var key = func(item);
        if (!grouped[key]) {
            grouped[key] = [];
        }
        grouped[key].push(item);
    });
 
    return grouped;
}
 
var data = [
    {name: "Alice", age: 21},
    {name: "Max", age: 20},
    {name: "Eve", age: 20},
    {name: "John", age: 30}
];
 
console.log(groupBy(data, function(person) {
    return person.age;
}));
// {20: [{name: "Max", age: 20}, {name: "Eve", age: 20}], 30: [{name: "John", age: 30}]}
