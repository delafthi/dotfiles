---
allowed-tools: Read, Write, Glob, Grep, Bash
description: Create comprehensive, high-quality test cases for the provided files or current changes.
---

Create comprehensive, high-quality test cases for the files $ARGUMENTS or the current changes.

## Task Planning

Use the TodoWrite tool to track testing steps:

1. Identify files to test
1. Understand project testing approach
1. Discover test command
1. Generate test cases for each file
1. Document how to run tests
1. Verify tests can be executed

Mark tasks as in_progress/completed as you work.

## Build System and Test Command Discovery

First, detect the build system and discover how to run tests:

```bash
if [ -f flake.nix ]; then
  echo "nix"
elif [ -f justfile ] || [ -f Justfile ]; then
  echo "just"
else
  echo "language-specific"
fi
```

**Nix:**

- Primary: `nix flake check`
- Alternative: `nix build .#checks.x86_64-linux.<test-name>`
- Show available checks: `nix flake show`

**Just:**

- List tasks: `just --list`
- Look for test-related tasks: `just test`, `just check`, etc.

**Language-specific:**

- Python: `pytest`, `python -m pytest`, `python -m unittest`
- JavaScript/TypeScript: `npm test`, `npm run test`, `yarn test`
- Rust: `cargo test`
- Go: `go test ./...`
- Java: `mvn test`, `gradle test`

Check project README/CONTRIBUTING for the preferred test command.

## Analysis

Understand the project's testing approach:

- Identify the project type and dependencies
- Examine existing test files to understand:
  - Testing framework and patterns used
  - Test structure and organization
  - Naming conventions
  - Assertion styles
  - Mocking/stubbing approaches
- Check for test configuration files (e.g., `jest.config.js`, `pytest.ini`, `Cargo.toml [dev-dependencies]`)
- Review test coverage requirements if documented

## Testing Frameworks

Use the project's established testing framework. Common frameworks by language:

- **Python**: pytest (preferred), unittest, nose2
- **JavaScript/TypeScript**: Jest, Vitest, Mocha, Jasmine
- **Rust**: Built-in `cargo test`, proptest (property testing)
- **Go**: Built-in `testing` package, testify
- **Java**: JUnit, TestNG, Mockito

## Test Structure

Organize tests following the project's conventions. Common patterns:

- **AAA Pattern**: Arrange → Act → Assert
- **Given-When-Then**: BDD-style test organization
- **Test file naming**: `test_*.py`, `*.test.ts`, `*_test.go`, etc.
- **Test function naming**: Descriptive, follows project convention

## Coverage Requirements

Generate tests for:

### 1. Happy Path (Normal Cases)

- Expected inputs and outputs
- Typical use cases
- Valid data scenarios

### 2. Edge Cases

- Boundary conditions (min/max values, empty collections)
- Special values (null, undefined, zero, empty strings)
- Off-by-one scenarios
- Unusual but valid inputs

### 3. Error Conditions

- Invalid inputs
- Missing required parameters
- Type mismatches
- Network/IO failures
- Race conditions (if applicable)
- Exception handling

### 4. Integration Points

- External dependencies (mock/stub appropriately)
- API interactions
- Database operations
- File system operations

## Requirements

- Follow project's existing test patterns and style
- Write clear, descriptive test names that explain what is being tested
- Use appropriate assertions (prefer specific over generic)
- Keep tests isolated and independent (no shared state)
- Mock external dependencies appropriately
- Include setup/teardown when needed
- Add docstrings/comments only for complex test logic
- Ensure tests are deterministic (no random values without seeds)
- Test one concept per test function
- Keep tests simple and readable

## Quality Guidelines

- Tests should fail for the right reasons
- Prefer readability over DRY in tests
- Use test fixtures/factories for complex data setup
- Avoid testing implementation details; focus on behavior
- Include both positive and negative test cases
- Consider performance for tests that run frequently

## Exclusions

Do NOT test:

- Third-party library internals
- Trivial getters/setters without logic
- Auto-generated code
- Private methods in isolation (test through public API)
- Framework/language built-ins

## Output

- Generate complete, runnable test files
- Follow project's test file organization
- Include necessary imports and setup
- Add TODO comments for tests requiring manual setup (e.g., integration tests needing infrastructure)
- Keep test code minimal and concise

## Test Execution Documentation

At the end of your response, include a section explaining how to run the tests:

**Format:**

```md
## Running Tests

Based on the detected build system:

[Include the appropriate command(s) discovered during analysis]

**Examples:**
- `nix flake check` - Run all checks (Nix projects)
- `just test` - Run tests (Just projects)
- `cargo test` - Run tests (Rust projects)
- `npm test` - Run tests (Node.js projects)
```

This helps users immediately verify that the tests work.
