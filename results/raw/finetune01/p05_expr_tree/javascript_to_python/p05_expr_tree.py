from collections import deque
 
def parse(tokens):
    """Parse a list of tokens into an expression tree."""
    # Stack of nodes.
    s = []
    for token in tokens:
        if isinstance(token, Node):
            s.append(token)
        elif isinstance(token, str):
            # Assume it is an operator.
            node = Node(token)
            node.right = s.pop()
            node.left = s.pop()
            s.append(node)
        else:
            raise ValueError('Unknown token type.')
    assert len(s) == 1
    return s[0]
 
class Node(object):
    def __init__(self, value=None, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right
 
    def __repr__(self):
        return '<Node %s>' % self.value
 
    def __str__(self):
        if self.left is None and self.right is None:
            return '%s' % self.value
        else:
            return '(%s)' % ' '.join(str(self.left), self.value, str(self.right))
 
if __name__ == '__main__':
    tokens = ['(', '2', '+', '3', '*', '4', ')']
    print(parse(tokens))
