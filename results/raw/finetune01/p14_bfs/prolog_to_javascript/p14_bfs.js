function bfs(graph, start, end) {
    var queue = [];
    queue.push(start);
 
    while(queue.length > 0){
        var node = queue.shift();
        if(node == end)
            return true;
        graph[node].forEach(function(item){
            queue.push(item);
        });
    }
    return false;
}
 
var g = {a:['b','c'], b:['d'], c:['d'], d:[], e:[]};
console.log(bfs(g,'a','d')); //true
console.log(bfs(g,'a','e')); //false
