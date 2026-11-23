class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
 
    def __repr__(self):
        return '<Node %r>' % self.value
 
    def add(self, value):
        if value <= self.value:
            if self.left is None:
                self.left = Node(value)
            else:
                self.left.add(value)
        elif self.right is None:
            self.right = Node(value)
        else:
            self.right.add(value)
 
    def inorder(self):
        if self.left is not None:
            yield from self.left.inorder()
        yield self.value
        if self.right is not None:
            yield from self.right.inorder()
 
    def preorder(self):
        yield self.value
        if self.left is not None:
            yield from self.left.preorder()
        if self.right is not None:
            yield from self.right.preorder()
 
    def postorder(self):
        if self.left is not None:
            yield from self.left.postorder()
        if self.right is not None:
            yield from self.right.postorder()
        yield self.value
 
    def height(self):
        left_height = self.left.height() if self.left is not None else 0
        right_height = self.right.height() if self.right is not None else 0
        return 1 + max(left_height, right_height)
 
if __name__ == '__main__':
    tree = Node(5)
    tree.add(2)
    tree.add(7)
    tree.add(8)
    tree.add(6)
    tree.add(9)
    tree.add(1)
    tree.add(3)
 
    print('In-order:', list(tree.inorder()))
    print('Pre-order:', list(tree.preorder()))
    print('Post-order:', list(tree.postorder()))
    print('Height:', tree.height())
