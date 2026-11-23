function StackVM() {
 
    var stack = [];
    var pc = 0;
 
    function push(val) { stack.push(val); }
    function pop() { return stack.pop(); }
    function peek() { return stack[stack.length - 1]; }
 
    this.run = function(code) {
        while(pc < code.length) {
            var instr = code[pc];
            switch(instr.opcode) {
                case "PUSH":
                    push(instr.value);
                    break;
                case "POP":
                    if(stack.length == 0) throw new Error("Stack underflow");
                    pop();
                    break;
                case "ADD":
                    if(stack.length < 2) throw new Error("Stack underflow");
                    var a = pop(), b = pop();
                    push(a + b);
                    break;
                case "MUL":
                    if(stack.length < 2) throw new Error("Stack underflow");
                    var a = pop(), b = pop();
                    push(a * b);
                    break;
                case "DUP":
                    if(stack.length == 0) throw new Error("Stack underflow");
                    push(peek());
                    break;
                case "SWAP":
                    if(stack.length < 2) throw new Error("Stack underflow");
                    var a = pop(), b = pop();
                    push(a);
                    push(b);
                    break;
                default:
                    if(stack.length == 0) throw new Error("Stack underflow");
                    console.log(pop());
                    break;
            }
            pc++;
        }
    };
}
 
var vm = new StackVM();
vm.run([
    {opcode:"PUSH", value:5},
    {opcode:"PUSH", value:3},
    {opcode:"ADD"},
    {opcode:"PUSH", value:4},
    {opcode:"MUL"},
    {opcode:"PUSH", value:2},
    {opcode:"DIV"},
    {opcode:"PUSH", value:7},
    {opcode:"SUB"},
    {opcode:"PRINT"}
]);
