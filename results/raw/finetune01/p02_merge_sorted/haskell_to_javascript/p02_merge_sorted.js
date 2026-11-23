function merge(a, b){
    var i=0,j=0;
    while(i<a.length && j<b.length){
        if(a[i]<b[j]) {yield a[i];i++;}
        else           {yield b[j];j++;}
    }
    while(i<a.length){yield a[i];i++}
    while(j<b.length){yield b[j];j++}
}
 
for(var v of merge([1,3,5],[2,4,6])){print(v)}
