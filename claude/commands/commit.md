---
description: "Stage and commit all changes with an AI-generated meaningful commit message"
allowed-tools:
  - "Bash(git add:*)"
  - "Bash(git status:*)"
  - "Bash(git commit:*)"
  - "Bash(git diff:*)"
  - "Bash(git log:*)"
---

# Commit All Changes

Create a meaningful commit for all pending changes following repository conventions.

## Workflow

1. **Analyze changes in parallel**:

   - Run `git status --porcelain` to see untracked and modified files
   - Run `git diff` to see staged and unstaged changes
   - Run `git log -5 --oneline` to understand recent commit message style

2. **Review and prepare**:

   - Identify the nature of changes (new feature, bug fix, refactor, etc.)
   - Check for files that should not be committed (secrets, credentials, .env files)
   - Warn if sensitive files are detected

3. **Stage relevant files**:

   - Stage all appropriate files with `git add .`
   - Skip committing if no changes exist

4. **Generate commit message**:

   - Follow conventional commits format: `type(scope): description`
   - **Commit types**: feat, fix, docs, style, refactor, test, chore, perf, ci, build
   - Use imperative mood ("add" not "added", "fix" not "fixed")
   - Keep description concise (1-2 sentences focusing on "why" not "what")
   - Include footer with:

     ```
     🤖 Generated with [Claude Code](https://claude.com/claude-code)

     Co-Authored-By: Claude <noreply@anthropic.com>
     ```

5. **Commit using HEREDOC**:

   ```bash
   git commit -m "$(cat <<'EOF'
   type(scope): description

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

6. **Verify**: Run `git status` after commit to confirm success

## Important Notes

- Do NOT push to remote unless explicitly requested
- Do NOT use `--no-verify` or skip hooks
- Do NOT commit if no changes exist
- Do NOT read additional files beyond git commands
- If pre-commit hooks modify files, check if safe to amend (check authorship and push status)

Execute this workflow now for all pending changes.
