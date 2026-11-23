(() => {
    'use strict';
 
    // -------------------------- TEST --------------------------
    const main = () =>
        console.log(
            JSON.stringify(
                map(
                    lines,
                    s => (
                        [s, brackets(s)]
                    )
                ),
                null,
                2
            )
        );
 
 
    // ---------------------- BRACKETS ------------------------
    // brackets :: String -> Bool
    const brackets = s =>
        let v = [];
        for (const c of s) {
            switch (c) {
                case '(':
                case '[':
                case '{':
                    v.push(c);
                    break;
                case ')':
                    if ('(' !== v.pop()) return false;
                    break;
                case ']':
                    if ('[' !== v.pop()) return false;
                    break;
                case '}':
                    if ('{' !== v.pop()) return false;
                    break;
            }
        }
        return 0 === v.length;
 
 
    // --------------------- GENERIC ----------------------------
 
    // map :: (a -> b) -> [a] -> [b]
    const map = (f, xs) => xs.map(f);
 
 
    // MAIN ---
    return main();
})();
