import fs from 'node:fs';

class Node { 
    constructor(value, left = null, right = null) { 
        this.value = value; 
        this.left = left; 
        this.right = right; 
    } 
}

function insert(root, value) {
    const node = new Node(value);
    if (!root) return node;

    let current = root;
    while (true) {
        if (value < current.value) {
            if (!current.left) {
                current.left = node;
                return root;
            }
            current = current.left;
        } else {
            if (!current.right) {
                current.right = node;
                return root;
            }
            current = current.right;
        }
    }
}

function inorder(root, out) { 
    if (root) { 
        inorder(root.left, out); 
        out.push(root.value); 
        inorder(root.right, out); 
    } 
}

function preorder(root, out) { 
    if (root) { 
        out.push(root.value); 
        preorder(root.left, out); 
        preorder(root.right, out); 
    } 
}

function height(root) { 
    return root ? 1 + Math.max(height(root.left), height(root.right)) : 0; 
}

const line = fs.readFileSync(0, 'utf8').split('\n')[0];
const trimmed = (line || '').trim();
const values = trimmed ? trimmed.split(/\s+/).map(Number) : [];

let root = null; 
for (const value of values) root = insert(root, value);

const inOrder = [];
inorder(root, inOrder);

const preOrder = [];
preorder(root, preOrder);

console.log(inOrder.join(' ')); 
console.log(preOrder.join(' ')); 
console.log(height(root));
