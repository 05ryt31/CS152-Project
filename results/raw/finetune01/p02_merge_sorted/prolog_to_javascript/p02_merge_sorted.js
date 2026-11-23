function mergeSorted(a1,a2){
    var r = [];
    while(a1.length && a2.length)
        r.push(a1[0] < a2[0]?a1.shift():a2.shift());
    return r.concat(a1,a2);
}
 
var a1 = [3,5,7,9];
var a2 = [4,6,8,10];
 
document.write(mergeSorted(a1,a2));
