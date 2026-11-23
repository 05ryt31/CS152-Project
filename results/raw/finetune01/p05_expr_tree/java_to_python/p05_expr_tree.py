from collections import deque
 
def parse(tokens):
    """Parse a list of tokens into an expression tree."""
    # Stack for nodes.
    s_nodes = deque()
    # Stack for operators.
    s_opp = deque()
    # Priority dictionary.
    p_opp = {"+": 1, "-": 1, "*": 2}
    for t in tokens:
        if t.isdigit():
            s_nodes.append(t)
        elif t in "+-*":
            while len(s_opp) > 0 and p_opp[s_opp[-1]] >= p_opp[t]:
                r = s_nodes.pop()
                l = s_nodes.pop()
                o = s_opp.pop()
                n = "(%s %s %s)" % (l, o, r)
                s_nodes.append(n)
            s_opp.append(t)
    # Remaining operators and operands.
    while len(s_opp) > 0:
        r = s_nodes.pop()
        l = s_nodes.pop()
        o = s_opp.pop()
        n = "(%s %s %s)" % (l, o, r)
        s_nodes.append(n)
    return s_nodes[0]
 
if __name__ == "__main__":
    print(parse("1 + 2 * 3".split()))
    print(parse("(1 + 2) * 3".split()))
    print(parse("1 + 2 * 3 - 4 / 5".split()))
    print(parse("1 + 2 * 3 - 4 / 5 + 6 * 7 - 8 / 9 * 10".split()))
