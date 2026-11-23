from collections import deque
 
def build_tree(tokens):
    """Builds an expression tree from a list of tokens."""
    # Stack for storing nodes.
    node_stack = deque()
    # Queue for storing operators.
    op_queue = deque()
    while len(tokens) > 0:
        tok = tokens.popleft()
        if tok.isdigit():
            node_stack.append(tok)
        elif tok == '(':
            op_queue.append(tok)
        elif tok == ')':
            while op_queue[-1] != '(':
                process_node(node_stack, op_queue)
            op_queue.pop() # Remove '('
        else:
            while (len(op_queue) > 0 and 
                   precedence[op_queue[-1]] >= precedence[tok]):
                process_node(node_stack, op_queue)
            op_queue.append(tok)
    while len(op_queue) > 0:
        process_node(node_stack, op_queue)
    return node_stack[0]
 
def process_node(nodes, ops):
    """Pops an operator and two operands from their respective stacks,
       creates a new node, and pushes it onto the nodes stack."""
    node2 = nodes.pop()
    node1 = nodes.pop()
    op = ops.pop()
    nodes.append(Node(op, node1, node2))
 
class Node(object):
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right
 
    def __str__(self):
        if self.left is None and self.right is None:
            return self.value
        else:
            return '(%s %s %s)' % (self.left, self.value, self.right)
 
# Precedence dictionary.
precedence = {'+': 1, '-': 1, '*': 2}
 
if __name__ == '__main__':
    print(build_tree(deque('1 + 2 * 3'.split())))
    print(build_tree(deque('(1 + 2) * 3'.split())))
    print(build_tree(deque('1 + (2 * 3)'.split())))
    print(build_tree(deque('1 + 2 * 3 - 4'.split())))
    print(build_tree(deque('1 + 2 * (3 - 4)'.split())))
    print(build_tree(deque('1 + ((2 * 3) - 4)'.split())))
    print(build_tree(deque('((1 + 2) * 3) - 4'.split())))
    print(build_tree(deque('1 + 2 * 3 - 4 / (5 - 6) ^ 7 ^ 8'.split())))
