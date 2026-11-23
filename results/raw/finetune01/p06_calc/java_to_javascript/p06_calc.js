function calc(expression){
	var stack = [];
	var operators = ['+', '-', '*', '/'];
	for(var i=0;i<expression.length;i++){
		if(isNaN(expression[i])){
			stack.push(expression[i]);
		}else{
			var num1 = parseInt(stack.pop(), 10);
			var num2 = parseInt(stack.pop(), 10);
			switch(expression[i]){
				case '+':
					stack.push(num2+num1);
					break;
				case '-':
					stack.push(num2-num1);
					break;
				case '*':
					stack.push(num2*num1);
					break;
				case '/':
					stack.push(num2/num1);
					break;
			}
		}
	}
	return stack[0];
}
 
calc('3+4*5');
// => 23
 
calc('(3+4)*5');
// => 35
 
calc('3+(4*5)');
// => 23
 
calc('3*(4+5)');
// => 27
 
calc('3*(4+5)/2');
// => 27/2
