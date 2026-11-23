```javascript
function mergeSortedArrays(a, b){
	var c = [];
	while(a.length && b.length)
		c.push((a[0]<b[0])?a.shift():b.shift());
	return c.concat(a,b);
}
 
mergeSortedArrays([1,3,5],[2,4,6]);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],true);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],false);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],null);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],undefined);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],"");
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],0);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],false);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],{});
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],[]);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],new Date());
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],NaN);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],Infinity);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-Infinity);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1/0);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1/0);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e+308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e+308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-308);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e307);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e307);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-307);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-307);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e306);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e306);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-306);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-306);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e305);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e305);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-305);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-305);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e304);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e304);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-304);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-304);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e303);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e303);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-303);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-303);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e302);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e302);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-302);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-302);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e301);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e301);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-301);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e-301);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e300);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],-1e300);
// [1,2,3,4,5,6]
 
mergeSortedArrays([1,3,5],[2,4,6],1e-300);
