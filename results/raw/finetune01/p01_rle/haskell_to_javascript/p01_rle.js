function rle(str) {
    var encoded = '';
    var i = 0;
 
    while(i < str.length){
        var char = str[i];
        var count = 0;
        while(char == str[i]){
            count++;
            i++;
        }
        encoded += count + char;
    }
 
    return encoded;
}
 
var s = 'AAAABBBCCDAA';
document.write(rle(s));
