function brackets(s) {
    var stack = [];
    for (var i = 0; i < s.length; i++) {
        switch (s[i]) {
            case "(":
            case "[":
            case "{":
                stack.push(s[i]);
                break;
            case ")":
                if (stack.pop() !== "(") return false;
                break;
            case "]":
                if (stack.pop() !== "[") return false;
                break;
            case "}":
                if (stack.pop() !== "{") return false;
                break;
        }
    }
    return stack.length === 0;
}
 
// test cases
print(brackets("()")); // true
print(brackets("([]{})")); // true
print(brackets("(]")); // false
print(brackets("{[()]}")); // true
print(brackets("[({})](]")); // false
