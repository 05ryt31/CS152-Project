function mergeSort(arr1, arr2){
	var sortedArr = [];
	while(arr1.length && arr2.length){
		if(arr1[0] < arr2[0]){
			sortedArr.push(arr1.shift());
		} else {
			sortedArr.push(arr2.shift());
		}
	}
	return [...sortedArr, ...arr1, ...arr2];
}
 
mergeSort([1,3,5],[2,4,6]); // [1,2,3,4,5,6]
