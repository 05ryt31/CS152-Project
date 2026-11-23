function groupBy(array, func) {
    var groups = {};
    array.forEach(function(item) {
        var key = func(item);
        if (!groups[key])
            groups[key] = [];
        groups[key].push(item);
    });
    return groups;
}
 
var data = [
    {key: 'a', value: 1},
    {key: 'b', value: 2},
    {key: 'a', value: 3},
    {key: 'c', value: 4},
    {key: 'b', value: 5},
];
 
console.log(groupBy(data, function(item) {return item.key}));
// {a: Array[2], b: Array[2], c: Array[1]}
