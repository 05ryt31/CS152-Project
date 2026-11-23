function parse(tokens) {
    var stack = [];
 
    for (var i = 0; i < tokens.length; i++) {
        var token = tokens[i];
        if (token === "+" || token === "-" || token === "*" || token === "/") {
            var right = stack.pop();
            var left = stack.pop();
            stack.push({ op: token, left: left, right: right });
        } else {
            stack.push(parseInt(token));
        }
    }
 
    return stack[0];
}
 
function print(tree) {
    if (typeof tree === "number") {
        return "" + tree;
    } else {
        return "(" + print(tree.left) + " " + tree.op + " " + print(tree.right) + ")";
    }
}
 
// Test
var tokens = "3 4 + 2 * 7 /".split(" ");
var tree = parse(tokens);
print(tree); // ((3+4)*2)/7
