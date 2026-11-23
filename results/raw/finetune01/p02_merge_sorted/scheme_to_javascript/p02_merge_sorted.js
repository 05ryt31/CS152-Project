function mergeSorted(a1, a2){
    var i = 0;
    var j = 0;
    var merged = [];
 
    while(i < a1.length && j < a2.length){
        if(a1[i] <= a2[j]){
            merged.push(a1[i]);
            i++;
        } else {
            merged.push(a2[j]);
            j++;
        }
    }
 
    // append remaining elements
    while(i < a1.length){
        merged.push(a1[i]);
        i++;
    }
 
    while(j < a2.length){
        merged.push(a2[j]);
        j++;
    }
 
    return merged;
}
 
var a1 = [3,5,7,9];
var a2 = [4,6,8,10];
 
print(mergeSorted(a1,a2));
