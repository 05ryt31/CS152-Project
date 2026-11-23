# Scheme

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Tail recursion and named `let` | Refrains from using tail recursion where it is appropriate. | Uses some tail recursion and named `let`, but inconsistently. | Uses tail recursion and named `let` consistently and naturally. |
| Iteration and structure | Uses imperative-like structure (i.e. deeply nested `if/else`) with unnecessary mutation. | Includes some awkward or imperative-like structures. | Uses clear, concise functional structures and recursion. |
| Higher-order functions | Reimplements common higher-order functions with custom functions. | Uses some higher-order functions, but misses other opportunities to use them. | Appropriately uses higher-order functions as much as possible. |
| Purity and side effects | Uses mutation or side effects in an imperative-like manner. | Includes avoidable mutation or side effects. | Keeps computation pure and allows side effects only when necessary (i.e. IO). |
| Abstraction and clarity | Uses overly complex, convoluted procedures with limited reusability. | Uses complex procedures with limited reusability. | Uses small, reusable procedures with clear purposes. |
| Naming conventions | Does not use appropriate formatting or Scheme naming conventions (i.e. no kebab case for identifiers). | Inconsistently uses formatting and naming conventions. | Uses consistent, appropriate Scheme naming conventions and formatting. |

# Haskell

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Pattern matching and guards | Extensively uses fragile checks or `if` statements. | Uses pattern matching and guards in some places, but still relies on fragile checks. | Uses clear pattern matching and guards with few to no fragile checks. |
| Iteration and structure | Uses imperative-like structure (i.e. deeply nested `if/else`) with unnecessary mutation. | Includes some awkward or imperative-like structures. | Uses clear, concise functional structures and recursion. |
| Higher-order functions | Reimplements common higher-order functions with custom functions. | Uses some higher-order functions, but misses other opportunities to use them. | Appropriately uses higher-order functions as much as possible. |
| Purity and side effects | Uses mutation or side effects in an imperative-like manner, including mutable `IORef`. | Includes avoidable mutation or side effects. | Keeps computation pure and allows side effects only when necessary (i.e. IO). |
| Abstraction and clarity | Uses overly complex, convoluted functions with limited reusability. | Uses complex functions with limited reusability. | Uses small, reusable functions with clear purposes. |
| Type signatures | Does not use signatures or only provides incorrect signatures. | Uses some correct signatures, but misses some signatures. | Provides clear, correct type signatures for all significant functions. |
