function BSTree(){
	this.root = null;
}
 
BSTree.prototype.insert = function(val){
	if(this.root === null){
		this.root = new Node(val);
		return;
	}
	var currentNode = this.root;
	while(true){
		if(currentNode.val > val){
			if(currentNode.left === null){
				currentNode.left = new Node(val);
				break;
			}else{
				currentNode = currentNode.left;
			}
		}else{
			if(currentNode.right === null){
				currentNode.right = new Node(val);
				break;
			}else{
				currentNode = currentNode.right;
			}
		}
	}
};
 
BSTree.prototype.inorder = function(){
	var arr = [];
	function traverse(node){
		if(node !== null){
			traverse(node.left);
			arr.push(node.val);
			traverse(node.right);
		}
	}
	traverse(this.root);
	return arr.join(" ");
};
 
BSTree.prototype.preorder = function(){
	var arr = [];
	function traverse(node){
		if(node !== null){
			arr.push(node.val);
			traverse(node.left);
			traverse(node.right);
		}
	}
	traverse(this.root);
	return arr.join(" ");
};
 
BSTree.prototype.height = function(){
	function traverse(node){
		if(node === null){
			return 0;
		}
		var left = traverse(node.left);
		var right = traverse(node.right);
		return Math.max(left,right)+1;
	}
	return traverse(this.root);
};
 
function Node(val){
	this.val = val;
	this.left = null;
	this.right = null;
}
 
var tree = new BSTree();
tree.insert(5);
tree.insert(3);
tree.insert(7);
tree.insert(2);
tree.insert(4);
tree.insert(6);
tree.insert(8);
 
console.log(tree.inorder());
console.log(tree.preorder());
console.log(tree.height());
