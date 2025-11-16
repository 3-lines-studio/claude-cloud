---
description: "Review branch changes before creating a pull request"
allowed-tools:
  - "Bash(git status:*)"
  - "Bash(git diff:*)"
  - "Bash(git log:*)"
  - "Bash(git branch:*)"
  - "Bash(git show:*)"
  - "Bash(git merge-base:*)"
  - "Read"
  - "Grep"
  - "Glob"
---

# Review Branch Changes

Perform comprehensive code review of all changes on the current branch to ensure quality before creating a pull request.

## Usage

Specify base branch to compare against (defaults to main if not provided):

- `/review` - compare against main
- `/review staging` - compare against staging
- `/review develop` - compare against develop

## Review Workflow

### 1. Gather Context (Run in Parallel)

- `git status` - current working state
- `git branch --show-current` - current branch name
- `git log --oneline -10` - recent commit history
- `git diff --stat <base>...HEAD` - files changed summary

### 2. Determine Base Branch

- Use provided argument or default to main/master
- Find merge base: `git merge-base <base> HEAD`
- Verify base branch exists

### 3. Analyze Commit History

- `git log <base>...HEAD --oneline` - all commits on this branch
- `git log <base>...HEAD --format='%h %s'` - commit messages
- Review commit message quality and conventions

### 4. Review Code Changes

- `git diff <base>...HEAD` - full diff of all changes
- Identify modified, added, and deleted files
- Read key changed files using Read tool to understand context
- Look for patterns, potential issues, and improvements

### 5. Security & Quality Checks

**Security Issues**:

- Hardcoded secrets, API keys, passwords, tokens
- Exposed credentials or sensitive data
- `.env` files or configuration with secrets
- Private keys, certificates, or authentication files

**Code Quality**:

- Code follows existing conventions and patterns
- Boolean conditions extracted to variables (not inlined)
- No unnecessary complexity or "clever" code
- Proper error handling
- Unused imports or dead code
- TODOs or FIXMEs that should be addressed

**Testing & Documentation**:

- Tests included for new features or bug fixes
- Documentation updated for API/behavior changes
- Breaking changes clearly documented
- README or setup instructions current

**Performance & Reliability**:

- No obvious performance issues or inefficiencies
- Large files or binary commits (check with `git diff --stat`)
- Memory leaks or resource management issues
- Race conditions or concurrency problems

### 6. Check for Conflicts

- `git merge-base <base> HEAD` - divergence point
- Check if base branch has moved ahead significantly
- Identify potential merge conflicts

### 7. Generate Review Summary

Provide structured feedback in this format:

#### 📊 Overview

- Current branch: `<branch-name>`
- Base branch: `<base-branch>`
- Commits: X commits
- Files changed: Y files (+A, -B lines)

#### ✅ Strengths

- List positive aspects of the changes

#### ⚠️ Issues Found

- **Critical**: Security issues, breaking changes
- **Major**: Code quality problems, missing tests
- **Minor**: Style inconsistencies, minor improvements

#### 💡 Recommendations

- Specific actionable suggestions for improvement
- Links to relevant files and line numbers using [file.ts:42](path/to/file.ts#L42) format

#### 🎯 Pre-PR Checklist

- [ ] All commits have meaningful messages
- [ ] No sensitive data exposed
- [ ] Code follows project conventions
- [ ] Tests included and passing
- [ ] Documentation updated
- [ ] No merge conflicts with base
- [ ] Breaking changes documented

## Important Notes

- Focus on substantive issues, not nitpicks
- Be specific with file/line references using markdown links
- Prioritize security and correctness over style
- Provide constructive, actionable feedback
- Use Read tool to understand context, don't just review diffs
- If changes are large, focus on high-impact areas first

Execute this comprehensive review process now.
