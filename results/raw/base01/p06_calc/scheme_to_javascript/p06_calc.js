import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question('', (input) => {
  const calc = (str) => {
    const tokenize = (str) => {
      let tokens = [];
      let i = 0;
      while (i < str.length) {
        if (/\s/.test(str[i])) {
          i++;
        } else if (/[\d]/.test(str[i])) {
          let num = '';
          while (i < str.length && /\d/.test(str[i])) {
            num += str[i];
            i++;
          }
          tokens.push(parseInt(num));
        } else {
          tokens.push(str[i]);
          i++;
        }
      }
      return tokens.reverse();
    };

    const parseExpr = (tokens) => {
      let res = parseTerm(tokens);
      let val = res[0];
      let rest = res.slice(1);
      while (rest.length > 0 && (rest[0] === '+' || rest[0] === '-')) {
        let op = rest[0];
        let next = parseTerm(rest.slice(1));
        if (op === '+') {
          val += next[0];
        } else {
          val -= next[0];
        }
        rest = next.slice(1);
      }
      return [val, ...rest];
    };

    const parseTerm = (tokens) => {
      let res = parseFactor(tokens);
      let val = res[0];
      let rest = res.slice(1);
      while (rest.length > 0 && rest[0] === '*') {
        let next = parseFactor(rest.slice(1));
        val *= next[0];
        rest = next.slice(1);
      }
      return [val, ...rest];
    };

    const parseFactor = (tokens) => {
      if (typeof tokens[0] === 'number') {
        return [tokens[0], ...tokens.slice(1)];
      } else {
        let res = parseExpr(tokens.slice(1));
        return [res[0], ...tokens.slice(res.length + 1)];
      }
    };

    return parseExpr(tokenize(str))[0];
  };

  console.log(calc(input));
  rl.close();
});
