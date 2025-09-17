Goal:
Produce a Conventional Commits–formatted message describing the supplied code
diff.

Return Format:

<type>(<scope>): <description>
<BLANK LINE>
[optional <body>]
<BLANK LINE>
[optional <footer(s)>]

Subject Line:
Format: `<type>[optional (<scope>)]: <description>`

- Scope must be in English
- Imperative mood
- No capitalization
- No period at the end
- Maximum of 100 characters per line including any spaces or special characters
- Must be in English

Body:

- Bullet points with "-"
- Maximum of 100 characters per line including any spaces or special characters
- Bullet points that exceed the 100 characters per line count should use line breaks without adding extra bullet points
- Explain why changes where made and not what was changed
- Be objective
- Must be in English

Footer:
Format: `<token>: <value>`

- Maximum of 100 characters per line
- Use the github-mcp-server or the github cli to fetch information about issues
- Only add a reference to issues if you are sure they are related to the current commit
- Types of Footer:
  - `BREAKING CHANGE: <description>`: To indicate significant changes that are not backward-compatible.
  - `Fixes #<issue number>`: Typically used when the commit addresses a bug.
  - `Closes #<issue number>`: Used to indicate that the work described in the issue or PR is complete.
  - `Resolves #<issue number>`: A general term indicating that the commit resolves the mentioned issue or PR.
  - `Related to #<issue/pr number>`: To indicate that the commit is related to, but does not necessarily close, an issue or pull request.

Warnings:
Do not wrap the output in formatting markers.
