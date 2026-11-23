function BSTree(){
	this.root = null;
}
 
BSTree.prototype.insert = function(val){
	if(this.root == null){
		this.root = new BSTNode(val);
		return true;
	}else{
		var node = this.root;
		while(true){
			if(node.val > val){
				if(node.left != null){
					node = node.left;
				}else{
					node.left = new BSTNode(val);
					break;
				}
			}else if(node.val < val){
				if(node.right != null){
					node = node.right;
				}else{
					node.right = new BSTNode(val);
					break;
				}
			}else{
				break;
			}
		}
	}
};
 
BSTree.prototype.inOrder = function(){
	var arr = [];
	this._inOrder(this.root, arr);
	return arr;
};
 
BSTree.prototype._inOrder = function(node, arr){
	if(node != null){
		this._inOrder(node.left, arr);
		arr.push(node.val);
		this._inOrder(node.right, arr);
	}
};
 
BSTree.prototype.preOrder = function(){
	var arr = [];
	this._preOrder(this.root, arr);
	return arr;
};
 
BSTree.prototype._preOrder = function(node, arr){
	if(node != null){
		arr.push(node.val);
		this._preOrder(node.left, arr);
		this._preOrder(node.right, arr);
	}
};
 
BSTree.prototype.height = function(){
	return this._height(this.root);
};
 
BSTree.prototype._height = function(node){
	if(node == null){
		return 0;
	}else{
		var left = this._height(node.left);
		var right = this._height(node.right);
		return Math.max(left, right) + 1;
	}
};
 
function BSTNode(val){
	this.val = val;
	this.left = null;
	this.right = null;
}
 
var bst = new BSTree();
bst.insert(5);
bst.insert(3);
bst.insert(7);
bst.insert(2);
bst.insert(4);
bst.insert(6);
bst.insert(8);
 
console.log(bst.inOrder());
console.log(bst.preOrder());
console.log(bst.height());
