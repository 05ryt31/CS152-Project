function BSTree() {
    this.root = null;
}
 
BSTree.prototype.insert = function(val) {
    var node = {val: val, left: null, right: null};
    if (!this.root) {
        this.root = node;
    } else {
        var current = this.root;
        while (true) {
            if (val < current.val) {
                if (current.left === null) {
                    current.left = node;
                    break;
                }
                current = current.left;
            } else {
                if (current.right === null) {
                    current.right = node;
                    break;
                }
                current = current.right;
            }
        }
    }
};
 
BSTree.prototype.inOrder = function(node) {
    if (node !== null) {
        this.inOrder(node.left);
        console.log(node.val);
        this.inOrder(node.right);
    }
};
 
BSTree.prototype.preOrder = function(node) {
    if (node !== null) {
        console.log(node.val);
        this.preOrder(node.left);
        this.preOrder(node.right);
    }
};
 
BSTree.prototype.height = function(node) {
    if (node === null) {
        return 0;
    } else {
        var leftHeight = this.height(node.left);
        var rightHeight = this.height(node.right);
        if (leftHeight > rightHeight) {
            return leftHeight + 1;
        } else {
            return rightHeight + 1;
        }
    }
};
 
var bst = new BSTree();
bst.insert(5);
bst.insert(3);
bst.insert(7);
bst.insert(2);
bst.insert(4);
bst.insert(6);
bst.insert(8);
bst.inOrder(bst.root);
bst.preOrder(bst.root);
console.log("Height:", bst.height(bst.root));
