 
var StackVM = function() {
    this.stack = [];
};
 
StackVM.prototype.push = function(val) {
    this.stack.push(val);
}
 
StackVM.prototype.pop = function() {
    if(this.stack.length > 0) {
        return this.stack.pop();
    } else {
        throw new Error("Error: Stack empty");
    }
}
 
StackVM.prototype.add = function() {
    var a = this.pop();
    var b = this.pop();
    this.push(a+b);
}
 
StackVM.prototype.mul = function() {
    var a = this.pop();
    var b = this.pop();
    this.push(a*b);
}
 
StackVM.prototype.dup = function() {
    var a = this.pop();
    this.push(a);
    this.push(a);
}
 
StackVM.prototype.swap = function() {
    var a = this.pop();
    var b = this.pop();
    this.push(a);
    this.push(b);
}
 
StackVM.prototype.print = function() {
    console.log(this.pop());
}
 
