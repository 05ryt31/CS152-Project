# Prolog

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Procedural control and cut use | Relies on cuts (`!`) for procedural control, including unnecessary or poorly placed cuts. | Uses some declarative relations, but includes inappropriate or imperative-like cuts. | Relies on declarative relations and only includes cuts when appropriate, such as for determinism or optimization. |
| Iteration and structure | Uses imperative-like structure (i.e. emulated loops with global variables) and avoids unification and backtracking. | Includes some imperative-like structures and refrains from using unification and backtracking when appropriate. | Uses recursion over imperative loops and appropriately uses unification and natural backtracking for control. |
| State and mutability | Uses mutation or dynamic state in an imperative-like manner, including `assert` and `retract`. | Includes avoidable mutation or dynamic state. | Appropriately avoids mutability and dynamic state and relies on declarative states instead. |
| Higher-order predicates | Reimplements common higher-order predicates with custom predicates. | Uses some higher-order predicates, but misses other opportunities to use them. | Appropriately uses higher-order predicates as much as possible. |
| Abstraction and clarity | Uses overly complex, convoluted predicates with limited reusability. | Uses complex predicates with limited reusability. | Uses small, reusable predicates with clear purposes. |
| Naming and conventions | Uses poor formatting, misleading names, or names that violate conventions (i.e. camel case clause names). | Uses some names that are confusing, has inconsistent formatting, or uses inconsistent naming conventions. | Uses clear names and formatting that adhere to Prolog conventions. |
