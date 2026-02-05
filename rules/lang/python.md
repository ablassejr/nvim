# Python Conventions (3.10+)

## System Prompt

You write modern, type-safe Python following current best practices.

### Tools Available

- **read_file**: Examine source code, pyproject.toml, requirements
- **grep_search**: Search for import patterns, function signatures
- **list_code_usages**: Trace function/class usage
- **context7** (MCP): Look up Python library docs (FastAPI, SQLAlchemy, pytest, etc.)

### Modern Python

- **Type hints on all function signatures** — parameters and return types
- **`dataclasses` or Pydantic models over raw dicts** for structured data
- **`pathlib.Path` over `os.path`** — cleaner, chainable, cross-platform
- **f-strings over `.format()` or `%`** — more readable, faster
- **Walrus operator `:=`** where it improves clarity (not forced)
- **`match`/`case` (3.10+)** for complex pattern matching — prefer over if/elif chains when matching structure

### Collections & Iteration

- **List/dict comprehensions** over `map`/`filter` — more Pythonic, more readable
- **Generators for large sequences** — `yield` instead of building full lists in memory
- **`itertools` and `functools`** for functional patterns
- **`collections.defaultdict`, `Counter`, `namedtuple`** — use stdlib before reaching for external libs

### Code Organization

- **`ruff`** for linting and formatting (replaces flake8, isort, black)
- **PEP 8** naming: `snake_case` functions/variables, `PascalCase` classes, `UPPER_CASE` constants
- **`__all__`** in public modules to declare exports
- **`if __name__ == "__main__":` guard** on executable modules
- **Explicit `__init__.py`** — don't rely on implicit namespace packages unless intentional

### Common Pitfalls

- **Mutable default arguments** — `def f(items=[])` shares the list across calls. Use `None` and create inside.
- **Late binding closures** — `lambda: i` in a loop captures the variable, not the value. Use `lambda i=i: i`.
- **Broad exception catching** — `except Exception` is almost always too broad. Catch specific exceptions.
- **`is` vs `==`** — use `is` only for `None`, `True`, `False` identity checks

### Testing

- **pytest** as test framework — fixtures, parametrize, markers
- **`pytest.raises`** for exception testing, `pytest.approx` for float comparison
- **conftest.py** for shared fixtures — scoped appropriately (function, module, session)
