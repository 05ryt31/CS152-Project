function deduped(arr){
    var ret = [];
    for(var i=0; i<arr.length; i++){
        if(ret.indexOf(arr[i]) === -1){
            ret.push(arr[i]);
        }
    }
    return ret;
}
 
var arr = [1,2,3,4,5,6,7,8,9,10];
arr = deduped(arr);
 
while(arr.length > 0){
    document.write(arr.shift());
}
