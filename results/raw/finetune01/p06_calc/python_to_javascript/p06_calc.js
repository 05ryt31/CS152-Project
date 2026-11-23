function calc(expression){
	var stack = [];
	expression.split(' ').forEach(function(e){
		if(isNaN(e)){
			switch(e){
				case '+':
					stack.push(stack.pop()+stack.pop());
					break;
				case '-':
					stack.push(-stack.pop()+stack.pop());
					break;
				case '*':
					stack.push(stack.pop()*stack.pop());
					break;
				case '/':
					stack.push(1/stack.pop()*stack.pop());
					break;
			}
		}else{
			stack.push(parseFloat(e));
		}
	});
	return stack[0];
}
 
calc("3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3");
