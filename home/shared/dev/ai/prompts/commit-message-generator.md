Goal: Produce a Conventional Commits–formatted message describing the supplied diff.

Return Format:

- `<type>(<scope>): <description>`
- Optional body with bullet points.
- Optional `BREAKING CHANGE: <description>` footer.

Warnings:

- Wrap lines under 100 characters.
- No extra text or formatting markers.
