import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

rl.question('', (input) => {
    const tokens = input.split('').reduce((acc, char) => {
        if (char === ' ') return acc;
        if ('+-*/()'.includes(char)) return [...acc, char];
        if ('0123456789'.includes(char)) {
            const match = input.slice(acc.length).match(/^(\d+)/);
            if (match) return [...acc, match[0]];
        }
        return acc;
    }, []);

    const parseExpression = (p) => {
        const [x, rest] = parseTerm(p);
        return parseAdds(x, rest);
    };

    const parseAdds = (x, rest) => {
        if (rest[0] === '+' || rest[0] === '-') {
            const [y, restPrime] = parseTerm(rest.slice(1));
            return parseAdds(
                rest[0] === '+' ? x + y : x - y,
                restPrime
            );
        }
        return [x, rest];
    };

    const parseTerm = (p) => {
        const [x, rest] = parseFactor(p);
        return parseMuls(x, rest);
    };

    const parseMuls = (x, rest) => {
        if (rest[0] === '*') {
            const [y, restPrime] = parseFactor(rest.slice(1));
            return parseMuls(x * y, restPrime);
        }
        return [x, rest];
    };

    const parseFactor = (p) => {
        if (p[0] === '(') {
            const [x, restPrime] = parseExpression(p.slice(1));
            return [x, restPrime.slice(1)];
        }
        return [parseInt(p[0], 10), p.slice(1)];
    };

    const result = parseExpression(tokens)[0];
    console.log(result);

    rl.close();
});
