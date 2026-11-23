var data = [
	{key:'a',value:3},
	{key:'b',value:5},
	{key:'a',value:4},
	{key:'c',value:9},
	{key:'b',value:1}
];
 
function groupBy(data, key) {
	var groups = {};
	data.forEach(function(item){
		if (!groups[item[key]]) {
			groups[item[key]] = [];
		}
		groups[item[key]].push(item);
	});
	return groups;
}
 
var groupedData = groupBy(data, 'key');
for (var k in groupedData) {
	console.log(k + ': ' + JSON.stringify(groupedData[k]));
}
