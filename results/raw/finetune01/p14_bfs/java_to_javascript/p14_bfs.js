function bfs(graph, start, end){
	var queue = [];
	queue.push([start]);
	while(queue.length > 0){
		var path = queue.shift();
		var vertex = path[path.length - 1];
		if(vertex === end){
			return path;
		}
		for(var i=0; i<graph[vertex].length; i++){
			var newPath = path.slice();
			newPath.push(graph[vertex][i]);
			queue.push(newPath);
		}
	}
	return null;
}
 
var graph = {};
graph.a = ['b', 'c'];
graph.b = ['a', 'd', 'e'];
graph.c = ['a', 'f'];
graph.d = ['b'];
graph.e = ['b', 'f'];
graph.f = ['c', 'e'];
 
console.log(bfs(graph, 'a', 'e')); // [ 'a', 'b', 'e' ]
console.log(bfs(graph, 'd', 'c')); // [ 'd', 'b', 'a', 'c' ]
