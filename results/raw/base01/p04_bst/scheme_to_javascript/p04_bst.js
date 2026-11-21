import { createInterface } from 'node:readline';
import { stdin, stdout } from 'node:process';

const rl = createInterface({
  input: stdin,
  output: stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line + '\n';
});

rl.on('close', () => {
  const lines = input.trim().split('\n');
  const numbers = lines[0].split(/\s+/).map(Number);
  
  class TreeNode {
    constructor(value) {
      this.value = value;
      this.left = null;
      this.right = null;
    }
  }

  function insert(tree, value) {
    if (!tree) return new TreeNode(value);
    if (value < tree.value) tree.left = insert(tree.left, value);
    else tree.right = insert(tree.right, value);
    return tree;
  }

  function inorder(tree) {
    if (!tree) return [];
    return [...inorder(tree.left), tree.value, ...inorder(tree.right)];
  }

  function preorder(tree) {
    if (!tree) return [];
    return [tree.value, ...preorder(tree.left), ...preorder(tree.right)];
  }

  function height(tree) {
    if (!tree) return 0;
    return Math.max(height(tree.left), height(tree.right)) + 1;
  }

  let root = null;
  for (const num of numbers) {
    root = insert(root, num);
  }

  console.log(inorder(root).join(' '));
  console.log(preorder(root).join(' '));
  console.log(height(root));
});
