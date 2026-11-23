function ExprTree(tokens) {
    this.tokens = tokens;
}
 
ExprTree.prototype.parse = function() {
    var stack = [];
    while(this.tokens.length > 0) {
        var token = this.tokens.shift();
        if(isNaN(token)) {
            var right = stack.pop();
            var left = stack.pop();
            stack.push({ op:token, left:left, right:right });
        } else {
            stack.push(parseInt(token));
        }
    }
    return stack[0];
};
 
ExprTree.prototype.toString = function(node) {
    if(typeof node === 'undefined') {
        node = this.parse();
    }
    if(typeof node.left !== 'undefined' && typeof node.right !== 'undefined') {
        return '(' + this.toString(node.left) + ' ' + node.op + ' ' + this.toString(node.right) + ')';
    } else {
        return node;
    }
};
 
var tree = new ExprTree('3 4 + 2 * 7 /'.split(/\s+/));
document.body.innerHTML += '<pre>' + tree.toString() + '</pre>';
