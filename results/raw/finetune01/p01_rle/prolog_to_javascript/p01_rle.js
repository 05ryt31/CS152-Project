function rleEncode(str){
	var encoded = '';
	for(var i=0; i<str.length; i++){
		var char = str.charAt(i);
		var count = 1;
		while(char == str.charAt(++i)){
			count++;
		}
		i--;
		encoded += count+char;
	}
	return encoded;
}
 
// test
var s = 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW';
document.write(rleEncode(s));
