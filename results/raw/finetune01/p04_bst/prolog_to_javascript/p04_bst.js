function BSTree() {
    this.root = null;
}
 
BSTree.prototype.insert = function(val) {
    var n = {value:val, left:null, right:null};
    if (this.root === null)
        this.root = n;
    else {
        var current = this.root;
        var parent;
        while(true){
            parent = current;
            if (val < current.value){
                current = current.left;
                if (current == null){
                    parent.left = n;
                    break;
                }
            }else{ // val >= current.value
                current = current.right;
                if (current == null){
                    parent.right = n;
                    break;
                }
            }
        }
    }
};
 
BSTree.prototype.inOrder = function(n) {
    if(n != null){
        this.inOrder(n.left);
        console.log(n.value.toString());
        this.inOrder(n.right);
    }
};
 
BSTree.prototype.preOrder = function(n) {
    if(n != null){
        console.log(n.value.toString());
        this.preOrder(n.left);
        this.preOrder(n.right);
    }
};
 
BSTree.prototype.postOrder = function(n) {
    if(n != null){
        this.postOrder(n.left);
        this.postOrder(n.right);
        console.log(n.value.toString());
    }
};
 
BSTree.prototype.height = function(n) {
    if(n == null)
        return -1;
    else{
        var lHeight = this.height(n.left);
        var rHeight = this.height(n.right);
        if(lHeight > rHeight)
            return (lHeight+1);
        else
            return (rHeight+1);
    }
};
 
var tree = new BSTree();
tree.insert(5);
tree.insert(3);
tree.insert(7);
tree.insert(2);
tree.insert(4);
tree.insert(6);
tree.insert(8);
tree.inOrder(tree.root);
tree.preOrder(tree.root);
tree.postOrder(tree.root);
console.log("Tree Height: "+tree.height(tree.root));
