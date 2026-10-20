# p08_bank: Bank account command log

Read an integer n, then n commands: `deposit X`, `withdraw X`, `balance`. Start from 0. `withdraw` that would go
below 0 prints `error` and leaves the balance unchanged; `balance` prints the current balance; `deposit` and
successful `withdraw` print nothing. Example: `4` / `deposit 50` / `withdraw 70` / `withdraw 20` / `balance` ->
`error` / `30`. Edge cases: withdraw exactly the balance, balance when 0, many errors in a row.
Paradigm notes: the OO shape (an account object) is natural; Haskell wants a fold or the State monad; Prolog must
thread the balance through a recursive predicate, where `assert`/`retract` is the non-idiomatic escape hatch.
