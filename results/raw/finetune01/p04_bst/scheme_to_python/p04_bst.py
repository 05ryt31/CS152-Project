class Node(object):
    def __init__(self, key=None, left=None, right=None):
        self.key = key
        self.left = left
        self.right = right
 
    def insert(self, key):
        if self.key is None:
            self.key = key
        elif self.key == key:
            pass # do nothing, don't allow duplicates
        elif key < self.key:
            if self.left is None:
                self.left = Node(key)
            else:
                self.left.insert(key)
        else:
            if self.right is None:
                self.right = Node(key)
            else:
                self.right.insert(key)
 
    def inorder(self):
        if self.left is not None:
            yield from self.left.inorder()
        yield self.key
        if self.right is not None:
            yield from self.right.inorder()
 
    def preorder(self):
        yield self.key
        if self.left is not None:
            yield from self.left.preorder()
        if self.right is not None:
            yield from self.right.preorder()
 
    def height(self):
        return 1 + max([self.left.height()] if self.left else [0],
                       [self.right.height()] if self.right else [0])
 
if __name__ == '__main__':
    tree = Node()
    for i in range(10):
        tree.insert(i)
    print(' '.join(str(x) for x in tree.inorder()))
    print(' '.join(str(x) for x in tree.preorder()))
    print(tree.height())
