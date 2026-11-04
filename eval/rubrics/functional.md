# Scheme

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Recursion and structural iteration | Emulates imperative loops with unnecessary mutation or complex control flow. | Uses recursion, but the structure is awkward or less appropriate than a simpler recursive approach. | Uses clear recursion that follows the structure of the data or computation. |
| Higher-order functions | Reimplements common list-processing behavior with unnecessary manual loops. | Uses some higher-order functions, but misses clear opportunities to use them. | Appropriately uses `map`, `filter`, `fold`, `apply`, or similar standard abstractions. |
| Purity and side effects | Uses mutation or side effects throughout the computation without necessity. | Mostly functional, but includes avoidable mutation or side effects. | Keeps computation pure and confines side effects primarily to the input/output boundary. |
| Tail recursion and named `let` | Uses non-tail recursion where tail recursion is natural, or creates unnecessarily complex iteration. | Uses tail recursion or named `let` inconsistently, or in a less natural form. | Uses tail recursion or named `let` naturally for iterative processes. |
| Data and list processing | Uses awkward indexing, mutation, or imperative manipulation instead of Scheme’s list-oriented operations. | Uses appropriate list operations in some places but handles data inconsistently. | Uses idiomatic constructors, selectors, list operations, and structural decomposition. |
| Abstraction and procedure use | Duplicates logic or uses overly specialized, monolithic procedures. | Has some useful procedures, but boundaries or reuse opportunities are imperfect. | Decomposes behavior into small, focused procedures and passes procedures where appropriate. |
| Binding and control constructs | Uses overly broad scope, unnecessary temporary variables, or convoluted conditionals. | Generally reasonable, but includes some avoidable nesting or awkward bindings. | Uses `let`, `let*`, `letrec`, `cond`, and related constructs clearly with appropriately scoped bindings. |

# Haskell

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Pattern matching | Relies primarily on explicit accessors, nested `if` chains, or fragile checks. | Uses pattern matching in some places but misses clear opportunities. | Uses clear pattern matching on data constructors, tuples, lists, and `Maybe`/`Either` values. |
| Recursion and structural iteration | Emulates imperative loops with unnecessary state or complex control flow. | Uses recursion, but the structure is awkward or less appropriate than a simpler approach. | Uses recursion that naturally follows the structure of the data or computation. |
| Higher-order functions | Reimplements standard list-processing behavior with manual recursion or loop-like code. | Uses some standard higher-order functions but misses obvious opportunities. | Appropriately uses functions such as `map`, `filter`, `foldr`, `foldl'`, `zipWith`, or `concatMap`. |
| Purity and `IO` discipline | Uses unnecessary `IORef`, `unsafePerformIO`, mutation, or `IO` for pure logic. | Mostly separates pure and impure code but includes avoidable effects or oversized `do` blocks. | Keeps computation pure and confines effects to a small, appropriate `IO` boundary. |
| Type signatures | Omits signatures for significant top-level definitions or uses vague, uninformative types. | Provides some useful signatures but omits or weakens others. | Provides clear, sufficiently general type signatures for significant top-level definitions. |
| Algebraic data and error representation | Uses sentinel values, partial functions, or ad hoc encodings where structured types are appropriate. | Uses `Maybe`, `Either`, or custom types inconsistently. | Uses algebraic data types, `Maybe`, and `Either` to represent alternatives and failure explicitly. |
| Abstraction and standard idioms | Duplicates logic or uses monolithic, highly specialized definitions. | Has some useful abstractions but misses clear opportunities for reuse or composition. | Uses small, composable functions, point-free style where readable, and standard library abstractions appropriately. |
