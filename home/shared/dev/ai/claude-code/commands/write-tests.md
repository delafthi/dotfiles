---
allowed-tools: Task
description: Create comprehensive, high-quality test cases for the provided files or current changes.
---

Create comprehensive, high-quality test cases for the files $ARGUMENTS or the current changes.

Spawn the code agent (background) to analyze the project's testing patterns and generate appropriate tests.

## Test Coverage Requirements

Generate tests for:

- **Happy path**: Expected inputs, typical use cases, valid scenarios
- **Edge cases**: Boundary conditions, special values, off-by-one scenarios
- **Error conditions**: Invalid inputs, type mismatches, exception handling
- **Integration points**: External dependencies (mock appropriately)

## Guidelines

- Follow project's existing test patterns and framework
- Use AAA pattern (Arrange, Act, Assert)
- Write clear, descriptive test names
- Keep tests isolated and deterministic
- Include setup/teardown when needed
- Document how to run tests

## Exclusions

Do NOT test third-party internals, trivial getters/setters, auto-generated code, or private methods in isolation.
