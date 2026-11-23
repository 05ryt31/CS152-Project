function ExprTree(tokens) {
    this.tokens = tokens;
}
 
ExprTree.prototype.build = function() {
    var stack = [];
    for (var i = 0; i < this.tokens.length; i++) {
        var token = this.tokens[i];
        if (token == "+" || token == "-" || token == "*" ) {
            var right = stack.pop();
            var left = stack.pop();
            stack.push(new Node(token, left, right));
        } else {
            stack.push(new Node(token));
        }
    }
    return stack[0];
};
 
ExprTree.prototype.render = function(node) {
    if (node.left === undefined && node.right === undefined) {
        return node.token;
    }
    return "(" + this.render(node.left) + " " + node.token + " " + this.render(node.right) + ")";
};
 
function Node(token, left, right) {
    this.token = token;
    this.left = left;
    this.right = right;
}
 
Node.prototype.toString = function() {
    return this.token;
};
 
// Test
var expr = new ExprTree("3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3".split(' ')).build();
print(expr);
print(new ExprTree([expr]).render());
