function pipeline(input, stages) {
    var data = input;
 
    for (var i = 0; i < stages.length; i++) {
        var stage = stages[i];
        switch (stage.type) {
            case 'map':
                data = map(data, stage.amount);
                break;
            case 'filter':
                data = filter(data, stage.name);
                break;
            case 'reduce':
                data = reduce(data, stage.name);
                break;
        }
    }
 
    return data;
}
 
function map(data, amount) {
    return data.map(function(item) {return item + amount});
}
 
function filter(data, type) {
    return data.filter(function(item) {
        if (type === 'even') {
            return item % 2 === 0;
        } else if (type === 'odd') {
            return item % 2 !== 0;
        } else if (type === 'gt') {
            return item > parseInt(type);
        }
    });
}
 
function reduce(data, type) {
    if (data.length === 0) {
        return 'none';
    }
 
    var max = data[0];
    for (var i = 1; i < data.length; i++) {
        if (type === 'max' && data[i] > max) {
            max = data[i];
        }
    }
 
    return max;
}
