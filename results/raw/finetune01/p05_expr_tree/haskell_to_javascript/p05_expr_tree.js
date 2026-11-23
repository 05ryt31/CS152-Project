function parse(s) {
    var tokens = s.split(/\s+/);
    return parseExpr(tokens);
}
 
function parseExpr(tokens) {
    if (tokens.length == 1)
        return new ExprNode(tokens[0]);
    var expr = parseTerm(tokens);
    while (tokens.length > 0 && tokens[0] == "+")
        expr = new ExprNode("+", expr, parseTerm(tokens));
    return expr;
}
 
function parseTerm(tokens) {
    var term = parseFactor(tokens);
    while (tokens.length > 0 && tokens[0] == "*")
        term = new ExprNode("*", term, parseFactor(tokens));
    return term;
}
 
function parseFactor(tokens) {
    if (tokens.length == 0)
        throw "Unexpected end of expression";
    var token = tokens.shift();
    if (token == "(") {
        var expr = parseExpr(tokens);
        if (tokens.length == 0 || tokens.shift() != ")")
            throw "Expected closing parenthesis";
        return expr;
    }
    return new ExprNode(token);
}
 
function ExprNode(op, left, right) {
    this.op = op;
    this.left = left;
    this.right = right;
}
 
ExprNode.prototype.toString = function () {
    if (this.op === undefined)
        return this.left;
    return "(" + this.left + " " + this.op + " " + this.right + ")";
};
 
// Test
var tree = parse("3 * 4 + 5");
print(tree.toString());
