from __future__ import print_function
 
class Node(object):
    def __init__(self, value=None, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right
 
    def __str__(self):
        return '(%s)' % self.value if isinstance(self.value, str) \
            else '%s' % self.value
 
    def __repr__(self):
        return '<Node %s>' % self.__str__()
 
    def __eq__(self, other):
        return self.value == other.value and self.left == other.left \
            and self.right == other.right
 
def parse(tokens):
    """Parse tokens into expression tree."""
    stack = []
    for token in tokens:
        if token.isdigit():
            node = Node(int(token))
        elif token in '+-*':
            node = Node(token)
            node.right = stack.pop()
            node.left = stack.pop()
        else:
            raise ValueError('Unknown token "%s"' % token)
        stack.append(node)
    assert len(stack) == 1
    return stack[0]
 
def pretty_print(tree, indent=0):
    """Pretty-print expression tree."""
    if tree is None:
        return ''
    if tree.value in '+-*':
        return (' ' * indent + pretty_print(tree.left, indent+2) +
                '\n' + ' ' * indent + tree.value + '\n' +
                ' ' * indent + pretty_print(tree.right, indent+2))
    else:
        return (' ' * indent + str(tree.value))
 
if __name__ == '__main__':
    # Test cases
    test_cases = [
        '1',
        '1 2 +',
        '1 2 3 * +',
        '1 2 3 + 4 * +',
        '1 2 + 3 4 + *',
        '1 2 + 3 4 * + 5 -',
        '1 2 + 3 4 * + 5 - 6 /',
        '1 2 + 3 4 * + 5 - 6 / 7 *',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 +',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 -',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 *',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 +',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 -',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 *',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 +',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 -',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 - 16 *',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 - 16 * 17 +',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 - 16 * 17 + 18 -',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 - 16 * 17 + 18 - 19 *',
        '1 2 + 3 4 * + 5 - 6 / 7 * 8 + 9 - 10 * 11 + 12 - 13 * 14 + 15 - 16 * 17 + 18 - 19 * 20 +',
    ]
    for i, tc in enumerate(test_cases):
        print('%i:' % i)
        tree = parse(tc.split())
        print('  parsed:', tree)
        print('  pretty printed:\n%s\n' % pretty_print(tree))
