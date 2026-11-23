function bfs(graph, start, end){
	var queue = [];
	queue.push(start);
	while(queue.length > 0){
		var vertex = queue.shift();
		if(vertex == end){
			return true;
		}
		for(var i in graph[vertex]){
			queue.push(graph[vertex][i]);
		}
	}
	return false;
}
 
var graph = {
	"A":["B","C"],
	"B":["A","D","E"],
	"C":["A","F"],
	"D":["B"],
	"E":["B","F"],
	"F":["C","E"]
};
 
print(bfs(graph,"A","F")); //true
print(bfs(graph,"A","D")); //true
print(bfs(graph,"A","G")); //false
