function rleEncode(str){
	var encoded = '';
	for(var i=0; i<str.length; i++){
		var char = str[i];
		var count = 0;
		while(char === str[i]){
			count++;
			i++;
		}
		encoded += count + char;
		i--;
	}
	return encoded;
}
 
// test
var s = 'aaabbcccddddeeeeffff';
print(rleEncode(s));
