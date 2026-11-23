function balancedBrackets(str){
	var brackets = {
		'(' : ')',
		'{' : '}',
		'[' : ']'
	};
 
	var stack = [];
	for(var i = 0; i < str.length; i++){
		if(brackets[str[i]]){
			stack.push(brackets[str[i]]);
		}
		else if(stack.pop() !== str[i]){
			return false;
		}
	}
	return stack.length === 0;
}
 
var tests = [
	'(){}[]', // true
	'(}',     // false
	'[(])',   // false
	'([{}])'  // true
];
 
for(var i = 0; i < tests.length; i++){
	console.log(tests[i] + ': ' + balancedBrackets(tests[i]));
}
