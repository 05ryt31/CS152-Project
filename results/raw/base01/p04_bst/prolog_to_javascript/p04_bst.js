import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let inputLines = [];
rl.on('line', (line) => {
  inputLines.push(line);
}).on('close', () => {
  const line = inputLines.join('\n');
  const nums = parseNums(line);
  let tree = empty;
  for (const num of nums) {
    tree = insert(num, tree);
  }
  const inOrder = inorder(tree);
  const preOrder = preorder(tree);
  printNums(inOrder);
  printNums(preOrder);
  console.log(height(tree));
  process.exit(0);
});

function parseNums(line) {
  if (line === '') return [];
  const parts = line.split(' ');
  if (parts.length === 0) return [];
  return parts.map(Number);
}

function insert(x, tree) {
  if (tree === empty) return { value: x, left: empty, right: empty };
  if (x < tree.value) return { ...tree, left: insert(x, tree.left) };
  return { ...tree, right: insert(x, tree.right) };
}

const empty = null;

function inorder(tree) {
  return inorderAcc(tree, []);
}

function inorderAcc(tree, acc) {
  if (tree === empty) return acc;
  return inorderAcc(tree.right, inorderAcc(tree.left, [...acc, tree.value]));
}

function preorder(tree) {
  return preorderAcc(tree, []);
}

function preorderAcc(tree, acc) {
  if (tree === empty) return acc;
  return [...acc, tree.value, ...preorderAcc(tree.right, preorderAcc(tree.left, []))];
}

function height(tree) {
  if (tree === empty) return 0;
  const leftHeight = height(tree.left);
  const rightHeight = height(tree.right);
  return 1 + Math.max(leftHeight, rightHeight);
}

function printNums(nums) {
  if (nums.length === 0) return '\n';
  const text = nums.join(' ');
  console.log(text);
}
