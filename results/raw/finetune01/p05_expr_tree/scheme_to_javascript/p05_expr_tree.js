function parse(tokens) {
    var stack = [];
 
    while (tokens.length > 0) {
        var token = tokens.shift();
        if (isOperator(token)) {
            var rhs = stack.pop();
            var lhs = stack.pop();
            stack.push([token, lhs, rhs]);
        } else {
            stack.push(parseInt(token));
        }
    }
 
    return stack[0];
}
 
function render(tree) {
    if (typeof tree === 'number') {
        return tree;
    } else {
        return '(' + render(tree[1]) + ' ' + tree[0] + ' ' + render(tree[2]) + ')';
    }
}
 
var expression = "3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3";
var tokens = expression.split(' ');
var tree = parse(tokens);
print(render(tree));
