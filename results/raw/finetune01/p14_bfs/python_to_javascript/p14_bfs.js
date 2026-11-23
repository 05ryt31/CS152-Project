// function bfs(graph, start, end){
// 	var queue = [];
// 	queue.push(start);
// 	while(queue.length > 0){
// 		var vertex = queue.shift();
// 		if(vertex === end){
// 			return true;
// 		}
// 		for(var i=0; i<graph[vertex].length; i++){
// 			var neighbor = graph[vertex][i];
// 			queue.push(neighbor);
// 		}
// 	}
// 	return false;
// }
//  
// var graph = {
// 	"A":["B","C"],
// 	"B":["A","D","E"],
// 	"C":["A","F"],
// 	"D":["B"],
// 	"E":["B","F"],
// 	"F":["C","E"]
// };
//  
// bfs(graph, "A", "F"); //true
// bfs(graph, "A", "D"); //true
// bfs(graph, "A", "Z"); //false
