 
var stack = [];
 
function push(val){
	stack.push(val);
}
 
function pop(){
	return stack.length > 0 ? stack.pop() : null;
}
 
function add(){
	var a = pop(), b = pop();
	if(a !== null && b !== null)
		push(a+b);
	else
		console.log('Error');
}
 
function mul(){
	var a = pop(), b = pop();
	if(a !== null && b !== null)
		push(a*b);
	else
		console.log('Error');
}
 
function dup(){
	var a = pop();
	if(a !== null)
		push(a), push(a);
	else
		console.log('Error');
}
 
function swap(){
	var a = pop(), b = pop();
	if(a !== null && b !== null)
		push(a), push(b);
	else
		console.log('Error');
}
 
function print(){
	var a = pop();
	if(a !== null)
		document.write(a + '<br>');
	else
		console.log('Error');
}
 
