import { readFileSync } from 'node:fs';
import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line.trim() + '\n';
});

rl.on('close', () => {
  const lines = input.trim().split('\n');
  let root = null;

  for (const line of lines) {
    for (const token of line.split(/\s+/)) {
      if (token) root = insert(root, parseInt(token));
    }
  }

  const inOrder = [];
  const preOrder = [];

  function inorder(node) {
    if (node) {
      inorder(node.left);
      inOrder.push(node.value);
      inorder(node.right);
    }
  }

  function preorder(node) {
    if (node) {
      preOrder.push(node.value);
      preorder(node.left);
      preorder(node.right);
    }
  }

  inorder(root);
  preorder(root);

  console.log(inOrder.join(' '));
  console.log(preOrder.join(' '));
  console.log(height(root));
});

function Node(value) {
  this.value = value;
  this.left = null;
  this.right = null;
}

function insert(root, value) {
  if (root === null) return new Node(value);
  let current = root;
  while (true) {
    if (value < current.value) {
      if (current.left === null) {
        current.left = new Node(value);
        return root;
      }
      current = current.left;
    } else {
      if (current.right === null) {
        current.right = new Node(value);
        return root;
      }
      current = current.right;
    }
  }
}

function height(node) {
  return node ? 1 + Math.max(height(node.left), height(node.right)) : 0;
}
