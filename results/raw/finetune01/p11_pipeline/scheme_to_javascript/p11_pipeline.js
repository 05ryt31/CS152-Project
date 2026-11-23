function pipeline(k, values) {
    var stages = [];
 
    while (true) {
        var stage = readline().split(' ');
        if (!stage.length) break;
        stages.push(stage);
    }
 
    for (var i = 0; i < k; i++) {
        var stage = stages[i];
        switch (stage[0]) {
            case 'map':
                values = map(values, parseInt(stage[2]));
                break;
            case 'filter':
                values = filter(values, parseInt(stage[2]), stage[1]);
                break;
            case 'reduce':
                values = reduce(values, stage[1]);
                break;
        }
    }
 
    printArray(values);
}
 
function map(array, value) {
    return array.map(function(x) {return x + value});
}
 
function filter(array, value, type) {
    if (type === 'even') {
        return array.filter(function(x) {return x % 2 == 0});
    } else if (type === 'odd') {
        return array.filter(function(x) {return x % 2 != 0});
    } else {
        return array.filter(function(x) {return x > value});
    }
}
 
function reduce(array, type) {
    if (type === 'sum') {
        return array.reduce(function(a, b) {return a + b}, 0);
    } else {
        return Math.max.apply(null, array);
    }
}
 
function printArray(array) {
    print(array.join(' '));
}
