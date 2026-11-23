function pipeline(input, stages){
    var result = input;
    for(var i=0; i<stages.length; i++){
        var stage = stages[i];
        if(stage[0] === 'map'){
            switch(stage[1]){
                case 'add':
                    result = result.map(function(x){return x + parseInt(stage[2]);});
                    break;
                case 'mul':
                    result = result.map(function(x){return x * parseInt(stage[2]);});
                    break;
            }
        }else if(stage[0] === 'filter'){
            switch(stage[1]){
                case 'even':
                    result = result.filter(function(x){return x % 2 === 0;});
                    break;
                case 'odd':
                    result = result.filter(function(x){return x % 2 !== 0;});
                    break;
                case 'gt':
                    result = result.filter(function(x){return x > parseInt(stage[2]);});
                    break;
            }
        }else if(stage[0] === 'reduce'){
            switch(stage[1]){
                case 'sum':
                    result = result.reduce(function(a,b){return a+b;}, 0);
                    break;
                case 'max':
                    result = Math.max.apply(null, result);
                    break;
            }
        }
    }
    return result;
}
 
var input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
var stages = [
    ['map', 'add', '3'],
    ['filter', 'even'],
    ['reduce', 'sum']
];
pipeline(input, stages); // => 30
