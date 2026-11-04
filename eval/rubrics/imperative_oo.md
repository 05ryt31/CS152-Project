# Java

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Class and object design | Places all logic in `main`, uses inappropriate static state, or ignores object structure where it is clearly useful. | Defines classes but assigns responsibilities or object boundaries inconsistently. | Uses classes and objects when appropriate, with responsibilities assigned to coherent abstractions. |
| Encapsulation | Exposes fields or mutable state unnecessarily, or uses public access as a substitute for design. | Encapsulates some state but has avoidable exposure or weak interfaces. | Keeps fields appropriately private and exposes behavior through clear methods and constructors. |
| Control flow and collections | Uses convoluted control flow, manual data handling, or unnecessary low-level loops or recursion. | Uses conventional control flow but misses some clearer constructs or collection operations. | Uses clear loops, enhanced `for` loops, collections, and control structures appropriate to the task. |
| Standard library use | Reimplements common functionality or uses outdated or inappropriate APIs without reason. | Uses standard library facilities in some places but misses obvious opportunities. | Makes appropriate use of the Java standard library, collections, utilities, and language features. |
| Error handling | Ignores foreseeable errors, catches exceptions indiscriminately, or uses exceptions for ordinary control flow. | Handles some errors appropriately but has gaps or overly broad handling. | Handles expected failures explicitly, preserves useful exception information, and avoids unnecessary exceptions. |
| Abstraction and duplication | Contains duplicated logic, overly large methods, or abstractions that obscure simple behavior. | Has reasonable structure but leaves some duplication or awkward method boundaries. | Uses focused methods, appropriate abstractions, and minimal duplication without overengineering. |
| Naming and conventions | Uses misleading names, inconsistent capitalization, or ignores standard Java naming conventions. | Names are generally understandable but include inconsistencies or vague choices. | Uses clear names and conventional Java naming for classes, methods, variables, and constants. |

# Python

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Control flow and comprehensions | Uses deeply nested lambdas, convoluted expressions, or unnatural control flow. | Uses ordinary control flow in some places but includes avoidable complexity. | Uses clear loops, comprehensions, generator expressions, and conditionals where each is natural. |
| Functions and object structure | Uses a monolithic script or inappropriate classes and functions with unclear responsibilities. | Has some useful decomposition but inconsistent boundaries or unnecessary structure. | Organizes code into focused functions and uses classes only when state or behavior benefits from them. |
| Standard library use | Reimplements common functionality or uses unnecessarily low-level techniques. | Uses standard library features inconsistently or misses clear opportunities. | Appropriately uses built-in types, standard-library functions, and common Python idioms. |
| Mutation and state management | Uses uncontrolled global or shared mutable state. | Limits shared state but includes avoidable mutation or unclear ownership. | Keeps state local and uses mutation deliberately, with clear ownership and simple data flow. |
| Error handling | Silently ignores errors, uses overly broad exception handling, or uses exceptions for ordinary branching. | Handles some failures appropriately but has gaps or overly broad handling. | Uses precise exception handling and communicates or propagates expected failures appropriately. |
| Abstraction and duplication | Repeats logic, uses unnecessarily elaborate abstractions, or creates helper functions with unclear value. | Has some useful abstraction but leaves duplication or awkward decomposition. | Uses small, reusable functions and straightforward abstractions without unnecessary complexity. |
| Naming and conventions | Uses unclear names, inconsistent formatting, or ignores common Python naming conventions. | Names and formatting are generally understandable but inconsistent. | Uses descriptive names and conventional Python naming and structure. |

# JavaScript

| Criterion | 0 - Not idiomatic | 1 - Partially idiomatic | 2 - Idiomatic |
|---|---|---|---|
| Control flow and functions | Uses deeply nested callbacks, lambda-like function chains, or unnecessarily convoluted control flow. | Uses clear control flow in some places but includes avoidable nesting or indirection. | Uses straightforward loops, conditionals, functions, and callbacks where appropriate. |
| Collections and higher-order operations | Uses awkward manual collection handling or reimplements common operations unnecessarily. | Uses array methods or iterators inconsistently. | Appropriately uses loops, `map`, `filter`, `reduce`, `find`, `some`, `every`, and related standard operations. |
| Object and module structure | Uses uncontrolled global state, overly large modules, or classes where simpler functions or objects would be clearer. | Has some useful structure but inconsistent module or object boundaries. | Uses modules, functions, objects, or classes appropriately, with clear responsibilities and limited shared state. |
| Asynchronous code | Uses deeply nested asynchronous callbacks, blocks unnecessarily, or mixes asynchronous styles confusingly. | Uses promises or `async`/`await` but has inconsistent flow or error propagation. | Uses `async`/`await` or promises clearly, avoids unnecessary nesting, and propagates asynchronous errors appropriately. |
| Standard library and language features | Reimplements common functionality or uses outdated or inappropriate language features without reason. | Uses standard features in some places but misses clear opportunities for reuse. | Makes appropriate use of built-in types, standard APIs, destructuring, modules, and modern language features. |
| Error handling | Silently ignores failures, uses overly broad handling, or relies on ad hoc error values. | Handles some failures appropriately but has gaps or inconsistent propagation. | Uses clear error handling, explicit failure propagation, and appropriate validation at boundaries. |
| Naming and conventions | Uses unclear names, inconsistent casing, or ignores common JavaScript conventions. | Names are generally understandable but include inconsistencies or vague choices. | Uses descriptive names and conventional JavaScript naming, formatting, and module organization. |
