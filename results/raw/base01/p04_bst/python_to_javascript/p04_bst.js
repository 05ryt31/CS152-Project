import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

let root = null;

function Node(value) {
  this.value = value;
  this.left = null;
  this.right = null;
}

function insert(root, value) {
  const node = new Node(value);
  if (root === null) {
    return node;
  }
  let current = root;
  while (true) {
    if (value < current.value) {
      if (current.left === null) {
        current.left = node;
        return root;
      }
      current = current.left;
    } else {
      if (current.right === null) {
        current.right = node;
        return root;
      }
      current = current.right;
    }
  }
}

function inorder(node, out) {
  if (node !== null) {
    inorder(node.left, out);
    out.push(node.value);
    inorder(node.right, out);
  }
}

function preorder(node, out) {
  if (node !== null) {
    out.push(node.value);
    preorder(node.left, out);
    preorder(node.right, out);
  }
}

function height(node) {
  if (node === null) {
    return 0;
  }
  return 1 + Math.max(height(node.left), height(node.right));
}

rl.on('line', (line) => {
  const tokens = line.split(' ').map(Number);
  tokens.forEach((token) => {
    root = insert(root, token);
  });
  const inValues = [];
  inorder(root, inValues);
  const preValues = [];
  preorder(root, preValues);
  console.log(inValues.join(' '));
  console.log(preValues.join(' '));
  console.log(height(root));
});
