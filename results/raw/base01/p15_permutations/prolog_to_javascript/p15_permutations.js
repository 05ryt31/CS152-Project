import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let input = '';

rl.on('line', (line) => {
    input += line + '\n';
});

rl.on('close', () => {
    const permutations = (str) => {
        if (str.length <= 1) return [str];
        let perms = [];
        for (let i = 0; i < str.length; i++) {
            let char = str[i];
            let remaining = str.slice(0, i) + str.slice(i + 1);
            for (let perm of permutations(remaining)) {
                perms.push(char + perm);
            }
        }
        return perms;
    };

    const sortedInput = input.split('').sort().join('');
    const uniquePerms = [...new Set(permutations(sortedInput))];
    uniquePerms.forEach(perm => console.log(perm));
});
