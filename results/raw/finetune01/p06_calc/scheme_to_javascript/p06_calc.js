function calc(expression){
	var stack = [];
	var operators = {
		'+': function(a,b){return a + b},
		'-': function(a,b){return a - b},
		'*': function(a,b){return a * b}
	};
	expression.split(' ').forEach(function(token){
		if(isNaN(parseFloat(token))){
			stack.push(operators[token](stack.pop(), stack.pop()));
		} else {
			stack.push(parseFloat(token));
		}
	});
	return stack[0];
}
 
// test cases
print(calc("1 2 +")); // 3
print(calc("1 2 3 + *")); // 9
print(calc("1 2 + 3 *")); // 9
print(calc("1 2 + 3 4 + *")); // 21
print(calc("1 2 + 3 4 + 5 * +")); // 31
