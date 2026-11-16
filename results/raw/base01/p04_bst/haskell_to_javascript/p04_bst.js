import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let values = [];
rl.on('line', (line) => {
    values = line.split(' ').map(Number);
}).on('close', () => {
    const tree = values.reduce((acc, val) => insert(acc, val), null);
    console.log(inorder(tree).join(' '));
    console.log(preorder(tree).join(' '));
    console.log(height(tree));
});

function insert(node, value) {
    if (!node) return { value, left: null, right: null };
    if (value < node.value) node.left = insert(node.left, value);
    else node.right = insert(node.right, value);
    return node;
}

function inorder(node) {
    if (!node) return [];
    return [...inorder(node.left), node.value, ...inorder(node.right)];
}

function preorder(node) {
    if (!node) return [];
    return [node.value, ...preorder(node.left), ...preorder(node.right)];
}

function height(node) {
    if (!node) return 0;
    return Math.max(height(node.left), height(node.right)) + 1;
}
