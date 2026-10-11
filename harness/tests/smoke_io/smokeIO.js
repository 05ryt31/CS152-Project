import * as readline from 'node:readline/promises';
import { stdin as input, stdout as output } from 'node:process';

const rl = readline.createInterface({ input, output });

const text = await rl.question('');

console.log(`Hello, ${text}`);

rl.close();
