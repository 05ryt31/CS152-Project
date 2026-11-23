function brackets(s) {
    var stack = [];
    for (var i = 0; i < s.length; i++) {
        if ("([{".indexOf(s[i]) != -1) {
            stack.push(s[i]);
        } else if (s[i] == ")" && stack[stack.length - 1] == "(" ||
                   s[i] == "]" && stack[stack.length - 1] == "[" ||
                   s[i] == "}" && stack[stack.length - 1] == "{") {
            stack.pop();
        }
    }
    return stack.length == 0;
}
 
brackets("()[]{}"); // true
brackets("{[]}()"); // true
brackets("(}");     // false
brackets("[(])");   // false
brackets("[({})](]")// false
