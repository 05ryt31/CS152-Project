class BSTNode(object):
    """A node in the binary search tree."""
 
    def __init__(self, key, parent):
        self.key = key
        self.parent = parent
        self.data = None
        self.left = None
        self.right = None
 
    def __repr__(self):
        return '<BSTNode {}>'.format(self.key)
 
    def insert(self, key, data=None):
        """Insert key/data pair into subtree with root *self*.
           Duplicate keys are ignored."""
        if key < self.key:
            if self.left is None:
                self.left = BSTNode(key, self)
            else:
                self.left.insert(key, data)
        elif key > self.key:
            if self.right is None:
                self.right = BSTNode(key, self)
            else:
                self.right.insert(key, data)
        else:
            raise ValueError("Key %s already present" % key)
 
    def remove(self, key):
        """Remove the node for key if present."
           If key is present, processing node has been attached to its
           predecessor and any children are attached to the predecessor
           so nothing escapes!"
        """
        node = self.find(key)
        if node is None:
            return
        if (node.left is not None) and (node.right is not None):
            pred = node.get_predecessor()
            node.key = pred.key
            node.data = pred.data
            node = pred
        child = node.left or node.right or None
        if child is not None:
            child.parent = node.parent
        if node.parent is not None:
            if node is node.parent.left:
                node.parent.left = child
            else:
                node.parent.right = child
        else:
            self.key = None
            self.data = None
            self.left = None
            self.right = None
 
    def find(self, key):
        """Return the node for key if present else None"""
        if self.key == key:
            return self
        elif key < self.key:
            if self.left is None:
                return None
            else:
                return self.left.find(key)
        elif key > self.key:
            if self.right is None:
                return None
            else:
                return self.right.find(key)
 
    def get_predecessor(self):
        "Return the predecessor of *self*"
        if self.left is not None:
            return self.left.get_max_node()
        else:
            node = self
            ancestor = node.parent
            while ancestor is not None and node is ancestor.left:
                node = ancestor
                ancestor = node.parent
            return ancestor
 
    def get_successor(self):
        "Return the successor of *self*"
        if self.right is not None:
            return self.right.get_min_node()
        else:
            node = self
            ancestor = node.parent
            while ancestor is not None and node is ancestor.right:
                node = ancestor
                ancestor = node.parent
            return ancestor
 
    def get_min_node(self):
        "Return the minimum node of the subtree rooted at *self*"
        node = self
        while node.left is not None:
            node = node.left
        return node
 
    def get_max_node(self):
        "Return the maximum node of the subtree rooted at *self*"
        node = self
        while node.right is not None:
            node = node.right
        return node
 
    def inorder_walk(self):
        "Inorder traversal of *self*"
        if self.left is not None:
            yield from self.left.inorder_walk()
        yield self
        if self.right is not None:
            yield from self.right.inorder_walk()
 
    def preorder_walk(self):
        "Preorder traversal of *self*"
        yield self
        if self.left is not None:
            yield from self.left.preorder_walk()
        if self.right is not None:
            yield from self.right.preorder_walk()
 
    def postorder_walk(self):
        "Postorder traversal of *self*"
        if self.left is not None:
            yield from self.left.postorder_walk()
        if self.right is not None:
            yield from self.right.postorder_walk()
        yield self
 
 
class BinarySearchTree(object):
    """Binary Search Tree implementation using BSTNode as nodes.
       This can be used with any comparable objects.
       It does not support 'in' operator or len().
    """
 
    def __init__(self):
        self.root = None
 
    def insert(self, key, data=None):
        """Insert key/data pair into tree"""
        if self.root is None:
            self.root = BSTNode(key, None)
        else:
            self.root.insert(key, data)
 
    def remove(self, key):
        """Remove node for key"""
        if self.root is not None:
            self.root.remove(key)
 
    def find(self, key):
        """Find node for key"""
        if self.root is not None:
            return self.root.find(key)
        else:
            return None
 
    def inorder_walk(self):
        "Inorder traversal of tree"
        if self.root is not None:
            yield from self.root.inorder_walk()
 
    def preorder_walk(self):
        "Preorder traversal of tree"
        if self.root is not None:
            yield from self.root.preorder_walk()
 
    def postorder_walk(self):
        "Postorder traversal of tree"
        if self.root is not None:
            yield from self.root.postorder_walk()
 
 
if __name__ == '__main__':
    bst = BinarySearchTree()
    for i in range(20):
        bst.insert(i)
    print(list(bst.inorder_walk()))
    print(list(bst.preorder_walk()))
    print(list(bst.postorder_walk()))
    bst.remove(10)
    print(list(bst.inorder_walk()))
    bst.remove(9)
    print(list(bst.inorder_walk()))
    bst.remove(8)
    print(list(bst.inorder_walk()))
    bst.remove(7)
    print(list(bst.inorder_walk()))
    bst.remove(6)
    print(list(bst.inorder_walk()))
    bst.remove(5)
    print(list(bst.inorder_walk()))
    bst.remove(4)
    print(list(bst.inorder_walk()))
    bst.remove(3)
    print(list(bst.inorder_walk()))
    bst.remove(2)
    print(list(bst.inorder_walk()))
    bst.remove(1)
    print(list(bst.inorder_walk()))
    bst.remove(0)
    print(list(bst.inorder_walk()))
