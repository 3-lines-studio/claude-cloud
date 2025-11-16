---
description: Execute a SMEAC feature request
argument-hint: <feature-name>
allowed-tools:
  - Bash
  - View
  - StrReplace
  - CreateFile
---

Read the feature request at `@./docs/features/$1.md` and implement it following the SMEAC framework.

**Process:**
1. Read and analyze all sections of the SMEAC spec
2. Verify all sections are filled out (if not, ask me to complete them)
3. Confirm understanding of the Mission and Acceptance criteria
4. Implement according to the Execution section
5. Respect all Constraints strictly
6. Verify all Acceptance criteria are met
7. Report completion with what was done and how to test

**Important:** When asking for clarifications, append all Q&A to the bottom of the feature doc under a `## Clarifications` section.

Do not deviate from the spec. Ask for clarification if anything is ambiguous.
