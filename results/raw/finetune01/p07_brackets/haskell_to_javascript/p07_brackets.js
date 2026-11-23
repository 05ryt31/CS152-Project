function brackets(s){
    var stack = [];
    for(var i=0; i<s.length; i++){
        switch(s[i]){
            case "(":
                stack.push(")");
                break;
            case "[":
                stack.push("]");
                break;
            case "{":
                stack.push("}");
                break;
            default:
                if(stack.pop() != s[i]) return false;
        }
    }
    return stack.length == 0;
}
 
var tests = ["([]){}", "[({})](]", "{}[", "[]{}(", "()", "[]{}", "((()))"];
for(var i in tests){
    console.log(tests[i] + ": " + brackets(tests[i]));
}
