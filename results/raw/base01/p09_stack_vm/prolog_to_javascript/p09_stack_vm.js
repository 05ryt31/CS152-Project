import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let stack = [];
let pc = 0;
let instructions = [];

rl.on('line', (line) => {
  instructions.push(line.split(' '));
});

function execute() {
  while (pc < instructions.length) {
    const instruction = instructions[pc];
    switch (instruction[0]) {
      case 'push':
        stack.push(parseInt(instruction[1]));
        break;
      case 'pop':
        if (stack.length === 0) {
          console.error('error');
        } else {
          stack.pop();
        }
        break;
      case 'add':
        if (stack.length < 2) {
          console.error('error');
        } else {
          stack.push(stack.pop() + stack.pop());
        }
        break;
      case 'mul':
        if (stack.length < 2) {
          console.error('error');
        } else {
          stack.push(stack.pop() * stack.pop());
        }
        break;
      case 'dup':
        if (stack.length === 0) {
          console.error('error');
        } else {
          stack.push(stack[stack.length - 1]);
        }
        break;
      case 'swap':
        if (stack.length < 2) {
          console.error('error');
        } else {
          [stack[stack.length - 2], stack[stack.length - 1]] = [stack[stack.length - 1], stack[stack.length - 2]];
        }
        break;
      case 'print':
        if (stack.length === 0) {
          console.error('error');
        } else {
          console.log(stack[stack.length - 1]);
        }
        break;
      default:
        console.error('error');
        return;
    }
    pc++;
  }
}

rl.on('close', () => {
  execute();
});
