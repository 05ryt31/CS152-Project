function dedupe(arr){
    var i=0;
    while(i<arr.length){
        if(arr.indexOf(arr[i]) !== i){
            arr.splice(i,1);
        }else{
            i++;
        }
    }
}
 
var arr = [1,2,3,4,5,6,7,8,9,10];
dedupe(arr);
alert(arr.join(", "));
