 
from collections import deque
 
class BSTNode(object):
    """A node in the binary search tree."""
    def __init__(self, key, parent):
        self.key = key
        self.parent = parent
        self.data = None
        self.left = None
        self.right = None

    def has_left_child(self):
        return self.left

    def has_right_child(self):
        return self.right

    def is_left_child(self):
        return self.parent and self.parent.left == self

    def is_right_child(self):
        return self.parent and self.parent.right == self

    def is_root(self):
        return not self.parent

    def is_leaf(self):
        return not (self.right or self.left)

    def has_any_children(self):
        return self.right or self.left

    def has_both_children(self):
        return self.right and self.left

    def replace_node_data(self, key, value, lc, rc):
        self.key = key
        self.data = value
        self.left = lc
        self.right = rc
        if self.has_left_child():
            self.left.parent = self
        if self.has_right_child():
            self.right.parent = self
 
class BinarySearchTree(object):
    """Binary Search Tree class"""
    def __init__(self):
        self.root = None
        self.size = 0

    def length(self):
        return self.size

    def put(self, key, val):
        if self.root:
            self._put(key, val, self.root)
        else:
            self.root = BSTNode(key, None)
            self.root.data = val
        self.size += 1

    def _put(self, key, val, currentNode):
        if key < currentNode.key:
            if currentNode.has_left_child():
                   self._put(key, val, currentNode.left)
            else:
                   currentNode.left = BSTNode(key, currentNode)
                   currentNode.left.data = val
        else:
            if currentNode.has_right_child():
                   self._put(key, val, currentNode.right)
            else:
                   currentNode.right = BSTNode(key, currentNode)
                   currentNode.right.data = val

    def get(self, key):
        if self.root:
            res = self._get(key, self.root)
            if res:
                   return res.data
            else:
                   return None
        else:
           return None

    def _get(self, key, currentNode):
        if not currentNode:
           return None
        elif currentNode.key == key:
           return currentNode
        elif key < currentNode.key:
           return self._get(key, currentNode.left)
        else:
           return self._get(key, currentNode.right)

    def delete(self, key):
        if self.size > 1:
           nodeToRemove = self._get(key, self.root)
           if nodeToRemove:
               self.remove(nodeToRemove)
               self.size -= 1
           else:
               raise KeyError('Error, key not in tree')
        elif self.size == 1 and self.root.key == key:
           self.root = None
           self.size -= 1
        else:
           raise KeyError('Error, key not in tree')

    def remove(self, currentNode):
        if currentNode.is_leaf(): #leaf
            if currentNode == currentNode.parent.left:
                currentNode.parent.left = None
            else:
                currentNode.parent.right = None
        elif currentNode.has_both_children(): #interior
            succ = currentNode.successor()
            succ.splice_out()
            currentNode.key = succ.key
            currentNode.data = succ.data
        else: #this node has one child
            if currentNode.has_left_child():
                if currentNode.is_left_child():
                    currentNode.left.parent = currentNode.parent
                    currentNode.parent.left = currentNode.left
                elif currentNode.is_right_child():
                    currentNode.left.parent = currentNode.parent
                    currentNode.parent.right = currentNode.left
                else:
                    rootNode = currentNode
                    currentNode.left.parent = None
                    currentNode.left.key = currentNode.key
                    currentNode.left.data = currentNode.data
                    currentNode = currentNode.left
            else:
                if currentNode.is_left_child():
                    currentNode.right.parent = currentNode.parent
                    currentNode.parent.left = currentNode.right
                elif currentNode.is_right_child():
                    currentNode.right.parent = currentNode.parent
                    currentNode.parent.right = currentNode.right
                else:
                    rootNode = currentNode
                    currentNode.right.parent = None
                    currentNode.right.key = currentNode.key
                    currentNode.right.data = currentNode.data
                    currentNode = currentNode.right

    def inorder_traversal(self):
        if self.root:
            return self.inorder(self.root)
        else:
            return []

    def inorder(self, node):
        if node is None:
            return []
        return self.inorder(node.left) + [node] + self.inorder(node.right)

    def preorder_traversal(self):
        if self.root:
            return self.preorder(self.root)
        else:
            return []

    def preorder(self, node):
        if node is None:
            return []
        return [node] + self.preorder(node.left) + self.preorder(node.right)

    def postorder_traversal(self):
        if self.root:
            return self.postorder(self.root)
        else:
            return []

    def postorder(self, node):
        if node is None:
            return []
        return self.postorder(node.left) + self.postorder(node.right) + [node]

    def level_order_traversal(self):
        if self.root:
            return self.level_order(self.root)
        else:
            return []

    def level_order(self, node):
        queue = deque([node])
        traversal = []
        while len(queue) != 0:
            node = queue.popleft()
            traversal.append(node)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        return traversal
 
if __name__ == '__main__':
    bst = BinarySearchTree()
    bst.put(50,'a')
    bst.put(30,'b')
    bst.put(20,'c')
    bst.put(40,'d')
    bst.put(70,'e')
    bst.put(60,'f')
    bst.put(80,'g')
    print(bst.inorder_traversal())
    print(bst.preorder_traversal())
    print(bst.postorder_traversal())
    print(bst.level_order_traversal())
 
