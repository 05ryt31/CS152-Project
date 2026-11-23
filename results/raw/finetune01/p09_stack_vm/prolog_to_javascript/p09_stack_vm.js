 
var stack = [];
 
function push(val){
	stack.push(val);
}
 
function pop(){
	return stack.pop();
}
 
function add(){
	var b = pop(), a = pop();
	push(a+b);
}
 
function mul(){
	var b = pop(), a = pop();
	push(a*b);
}
 
function dup(){
	var val = pop();
	push(val);
	push(val);
}
 
function swap(){
	var b = pop(), a = pop();
	push(b);
	push(a);
}
 
function print(){
	document.write(pop());
}
 
