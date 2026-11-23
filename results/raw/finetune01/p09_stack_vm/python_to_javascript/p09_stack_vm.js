 
var stack = [];
 
function push(val){
	stack.push(val);
}
 
function pop(){
	return stack.pop();
}
 
function add(){
	var a = pop(), b = pop();
	push(a+b);
}
 
function mul(){
	var a = pop(), b = pop();
	push(a*b);
}
 
function dup(){
	var a = pop();
	push(a); push(a);
}
 
function swap(){
	var a = pop(), b = pop();
	push(a); push(b);
}
 
function prn(){
	print(pop());
}
 
