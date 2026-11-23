 
function BST() {
    this.root = null;
}
BST.prototype.insert = function(val) {
    var n = new Node(val);
    if(this.root === null) {
        this.root = n;
    } else {
        var current = this.root;
        var parent;
        while(true){
            parent = current;
            if(val < current.val){
                current = current.left;
                if(current == null){
                    parent.left = n;
                    break;
                }
            }else{
                current = current.right;
                if(current == null){
                    parent.right = n;
                    break;
                }
            }
        }
    }
};
BST.prototype.inOrder = function(n) {
    if(n != null){
        this.inOrder(n.left);
        console.log(n.val.toString());
        this.inOrder(n.right);
    }
};
BST.prototype.preOrder = function(n) {
    if(n != null){
        console.log(n.val.toString());
        this.preOrder(n.left);
        this.preOrder(n.right);
    }
};
BST.prototype.postOrder = function(n) {
    if(n != null){
        this.postOrder(n.left);
        this.postOrder(n.right);
        console.log(n.val.toString());
    }
};
BST.prototype.getMin = function(){
    var current = this.root;
    while(current.left !== null){
        current = current.left;
    }
    return current.val;
};
BST.prototype.getMax = function(){
    var current = this.root;
    while(current.right !== null){
        current = current.right;
    }
    return current.val;
};
BST.prototype.find = function(val){
    var current = this.root;
    while(current.val != val){
        if(val < current.val){
            current = current.left;
        }else{
            current = current.right;
        }
        if(current == null){
            return null;
        }
    }
    return current;
};
BST.prototype.remove = function(val){
    var found = false;
    var parent = this.root;
    var current = this.root;
    while(!found && current != null){
        if(val < current.val){
            parent = current;
            current = current.left;
        }else if(val > current.val){
            parent = current;
            current = current.right;
        }else{
            found = true;
        }
    }
    if(current == null || !found){
        return null;
    }
    if(found){
        if(current.left == null && current.right == null){
            if(parent.left == current){
                parent.left = null;
            }else if(parent.right == current){
                parent.right = null;
            }
        }
        else if(current.left == null){
            if(parent.left == current){
                parent.left = current.right;
            }else if(parent.right == current){
                parent.right = current.right;
            }
        }
        else if(current.right == null){
            if(parent.left == current){
                parent.left = current.left;
            }else if(parent.right == current){
                parent.right = current.left;
            }
        }
        else if(current.left != null && current.right != null){
            var succParent = current;
            succ = current.right;
            while(succ.left != null){
                succParent = succ;
                succ = succ.left;
            }
            if(succParent.right == succ){
                succParent.right = succ.right;
            }else{
                succParent.left = succ.right;
            }
            current.val = succ.val;
        }
        return current.val;
    }
};
 
function Node(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}
 
var bst = new BST();
bst.insert(5);
bst.insert(3);
bst.insert(7);
bst.insert(2);
bst.insert(4);
bst.insert(6);
bst.insert(8);
bst.inOrder(bst.root);
bst.preOrder(bst.root);
bst.postOrder(bst.root);
console.log(bst.getMin());
console.log(bst.getMax());
console.log(bst.find(4));
console.log(bst.remove(4));
bst.inOrder(bst.root);
 
