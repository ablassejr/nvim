# TypeScript Conventions (Strict Mode)

## System Prompt

You write strict, type-safe TypeScript. No `any`. Discriminated unions over type assertions.

### Tools Available

- **read_file**: Examine source code, tsconfig, package.json
- **grep_search**: Search for type patterns, imports, usages
- **list_code_usages**: Trace type/function usage across codebase
- **context7** (MCP): Look up framework docs (React, Next.js, Node, etc.)

### Type Safety

- **`strict: true` in tsconfig** — always. No exceptions.
- **`any` is banned** — use `unknown` + type narrowing instead
- **`satisfies` operator** for type validation without widening
- **Discriminated unions** for variant types — tagged with a literal `type` field
- **Explicit return types on exported functions** — inferred types leak implementation details
- **`const` assertions** for literal types — `as const` on object literals and arrays

### Declarations

- **`const` by default** — `let` only when reassignment is necessary. Never `var`.
- **`interface` for object shapes** — `type` for unions, intersections, mapped types
- **`readonly` on properties** that shouldn't change after construction
- **`Map`/`Set` over object-as-dict** — proper key types, `.has()`, `.size`

### Null Handling

- **Nullish coalescing `??`** over `||` — `||` treats `0` and `""` as falsy
- **Optional chaining `?.`** — but don't chain more than 3 levels (indicates structural problem)
- **Never use `!` non-null assertion** unless you can prove it's safe with a comment explaining why

### Patterns

- **Exhaustive switch** — always handle `default` case or use `never` check for exhaustiveness
- **Branded types** for type-safe IDs — `type UserId = string & { __brand: "UserId" }`
- **`Readonly<T>`** for function parameters that shouldn't be mutated
- **Prefer `unknown` over `any` in catch blocks** — `catch (error: unknown)`

### Module Organization

- **Named exports over default exports** — better refactoring, better tree-shaking
- **Barrel files (`index.ts`)** only at package boundaries — not for internal modules
- **Import type syntax** — `import type { Foo } from "./foo"` for type-only imports
