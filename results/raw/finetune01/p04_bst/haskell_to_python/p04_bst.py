class BST(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
 
    def insert(self, value):
        if self.value == value:
            return False
        elif self.value > value:
            if self.left is not None:
                return self.left.insert(value)
            else:
                self.left = BST(value)
                return True
        else:
            if self.right is not None:
                return self.right.insert(value)
            else:
                self.right = BST(value)
                return True
 
    def find(self, value):
        if self.value == value:
            return True
        elif self.value > value:
            if self.left is not None:
                return self.left.find(value)
            else:
                return False
        else:
            if self.right is not None:
                return self.right.find(value)
            else:
                return False
 
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
        if self.left is not None and self.right is not None:
            return 1 + max(self.left.height(), self.right.height())
        elif self.left:
            return 1 + self.left.height()
        elif self.right:
            return 1 + self.right.height()
        else:
            return 1
 
if __name__ == '__main__':
    bst = BST(25)
    bst.insert(15)
    bst.insert(50)
    bst.insert(10)
    bst.insert(22)
    bst.insert(35)
    bst.insert(70)
    bst.insert(4)
    bst.insert(12)
    bst.insert(18)
    bst.insert(24)
    bst.insert(31)
    bst.insert(44)
    bst.insert(66)
    bst.insert(90)
    print('Inorder:', list(bst.inorder()))
    print('Preorder:', list(bst.preorder()))
    print('Postorder:', list(bst.postorder()))
    print('Height:', bst.height())
