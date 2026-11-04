# Java

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Mutation and state management | Consistently uses unnecessary global or shared states. | Limits global and shared states, but includes some avoidable global states or unclear ownership. | Keeps state local with clear ownership and little to no unnecessary shared states. |
| Encapsulation | Exposes many fields or methods unnecessarily. | Encapsulates some fields and methods, but exposes some unnecessary ones. | Encapsulates all appropriate fields and methods and only exposes when necessary. |
| Iteration and structure | Uses excessive recursion, low-level loops, or awkward structures. | Includes some awkward or poorly written loops and structures. | Uses clear, concise structures and iteration, including enhanced `for` loops. |
| Standard library use | Reimplements standard library functions or uses outdated or inappropriate ones. | Uses some standard library functions, but reimplements or misuses others. | Appropriately uses standard library functions. |
| Abstraction and clarity | Uses overly complex, convoluted functions or classes with limited reusability. | Uses complex functions or classes with limited reusability. | Uses small, reusable functions and classes with clear purposes. |
| Naming and conventions | Uses poor formatting, misleading names, or names that violate conventions (i.e. snake case class names). | Uses some names that are confusing, has inconsistent formatting, or uses inconsistent naming conventions. | Uses clear names and formatting that adhere to Java conventions. |

# Python

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Mutation and state management | Consistently uses unnecessary global or shared states. | Limits global and shared states, but includes some avoidable global states or unclear ownership. | Keeps state local with clear ownership and little to no unnecessary shared states. |
| Functional structures | Extensively uses higher-order functions or other hallmarks of functional Python. | Uses some higher-order functions or other functional structures where imperative ones are appropriate. | Primarily uses imperative loops and structures, with few to no higher-order functions. |
| Iteration and structure | Uses excessive recursion, low-level loops, or awkward structures. | Includes some awkward or poorly written loops and structures. | Uses clear, concise structures and iteration, including recursion only when appropriate. |
| Standard library use | Reimplements standard library functions or uses outdated or inappropriate ones. | Uses some standard library functions, but reimplements or misuses others. | Appropriately uses standard library functions and services. |
| Abstraction and clarity | Uses overly complex, convoluted functions or classes with limited reusability. | Uses complex functions or classes with limited reusability. | Uses small, reusable functions and classes with clear purposes. |
| Naming and conventions | Uses poor formatting, misleading names, or names that violate conventions (i.e. camel case function names). | Uses some names that are confusing, has inconsistent formatting, or uses inconsistent naming conventions. | Uses clear names and formatting that adhere to Python conventions. |

# JavaScript

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Functional incorporation | Uses imperative structures when functional ones would be beneficial, or vice versa. | Inconsistently uses imperative and functional structures. | Appropriately uses both imperative and functional structures. |
| Operators and variables | Uses `==` or `!=` instead of strict equality/inequality, or inappropriately uses `var` and `const` for variables. | Uses strict equality/inequality inconsistently or uses `const` and `var` inappropriately in certain cases. | Appropriately uses strict equality/inequality and applies `let` and `const` to variables. |
| Iteration and structure | Uses excessive recursion, low-level loops, or awkward structures. | Includes some awkward or poorly written loops and structures. | Uses clear, concise structures and iteration, including recursion only when appropriate. |
| Standard library use | Reimplements standard library functions or uses outdated or inappropriate ones. | Uses some standard library functions, but reimplements or misuses others. | Appropriately uses standard library functions and services. |
| Abstraction and clarity | Uses overly complex, convoluted functions or classes with limited reusability. | Uses complex functions or classes with limited reusability. | Uses small, reusable functions and classes with clear purposes. |
| Naming and conventions | Uses poor formatting, misleading names, or names that violate conventions (i.e. camel case function names). | Uses some names that are confusing, has inconsistent formatting, or uses inconsistent naming conventions. | Uses clear names and formatting that adhere to Python conventions. |
