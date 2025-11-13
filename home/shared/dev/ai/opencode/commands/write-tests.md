______________________________________________________________________

## description: write tests agent: build subtask: true template: Create comprehensive, high-quality test cases for the provided files or current changes.

Create comprehensive, high-quality test cases for the files $ARGUMENTS or the current changes.

## Analysis

First, understand the project's testing approach:

- Identify the project type and dependencies:
  !`find . -name "package.json" -o -name "Cargo.toml" -o -name "pyproject.toml" -o -name "go.mod" | head -1`
- Examine existing test files to understand:
  - Testing framework and patterns used
  - Test structure and organization
  - Naming conventions
  - Assertion styles
  - Mocking/stubbing approaches
- Check for test configuration files (e.g., `jest.config.js`, `pytest.ini`, `cargo test`)
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
