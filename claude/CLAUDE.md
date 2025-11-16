# Root Claude Code Configuration

Global preferences for all Claude Code sessions. These override default behavior.

## Context Optimization

**CRITICAL: Maximize coding session length by minimizing context token usage**

### Reading Files

- **Never read entire large files** - use offset/limit parameters strategically
- Read only the specific sections needed, not the whole file
- For exploration tasks, use Task agent with Explore subagent instead of direct reads
- Avoid re-reading files already in context unless absolutely necessary
- Use Grep with appropriate output modes (files_with_matches) instead of reading multiple files

### Tool Usage

- Prefer Grep over Read when searching for specific patterns
- Use Glob for file discovery, not listing contents
- Use Task agents for multi-step operations to isolate context
- Avoid using -A, -B, -C flags in Grep unless essential
- Set appropriate head_limit on Grep to cap results

### Communication

- Be extremely concise in explanations - no unnecessary elaboration
- Don't repeat information already established in the conversation
- Skip obvious descriptions of what tools do
- Avoid verbose summaries of changes - be direct and minimal
- Never output full file contents in responses unless explicitly requested

### Planning and Execution

- Use TodoWrite for tracking but keep descriptions brief
- Don't create todos for trivial single-step operations
- Execute tasks efficiently without excessive status updates
- Minimize thinking output - only when genuinely complex reasoning is needed

## Code Quality Principles

### Simplicity First

- Make solutions as simple and boring as possible
- Avoid premature optimization or over-engineering
- Prefer straightforward implementations over clever tricks
- Prioritize readability and maintainability over brevity
- Small, minimum viable changes for solutions

### Code Style

- **Boolean conditions**: Always extract to named variables, never inline in if statements

```javascript
// Good
const hasValidData = data && data.length > 0;
if (hasValidData) { ... }

// Bad
if (data && data.length > 0) { ... }
```

- No unnecessary comments unless explicitly requested
- Follow existing code patterns and conventions strictly
- Use descriptive variable and function names that explain intent

### Dependencies & Built-ins

- Minimize external dependencies
- Use built-in language features and standard library when possible
- Only add dependencies when they solve complex problems better than custom code
- Remove unused dependencies immediately

## File Management

### Modification Strategy

- **ALWAYS prefer editing existing files over creating new ones**
- Only create new files when absolutely necessary
- Never create documentation files (README.md, docs/) unless explicitly requested

### Organization

- Keep related functionality together
- Use consistent, descriptive naming conventions
- Clean up unused imports/dependencies immediately during any file edit
- Remove dead code during refactoring
- Delete commented-out code unless there's a documented reason to keep it

## Tool Usage

### Efficiency

- Run independent commands in parallel whenever possible
- Use specialized tools (Read, Edit, Grep, Glob) instead of bash for file operations
- Use Task agent for complex multi-step operations or open-ended searches

### Git Operations

- Never commit unless explicitly requested
- Never push unless explicitly requested
- Follow conventional commit format: `type(scope): description`
- Check for sensitive data before committing
- Use HEREDOC format for commit messages

## Communication Style

### Responses

- Be concise and direct, no fluff
- No emojis unless explicitly requested
- Provide context about what changed and why
- Explain trade-offs when multiple solutions exist
- Use markdown links for file references: `[file.ts:42](path/to/file.ts#L42)`

### Code Changes

- Document breaking changes and migration steps clearly
- Explain the reasoning behind non-obvious decisions
- Highlight potential risks or side effects
- When refactoring, explain what patterns improved and why

### Asking Questions

- Ask clarifying questions when requirements are ambiguous
- Present options when multiple valid approaches exist
- Confirm destructive operations before executing

## Task Management

### Planning

- Use TodoWrite for medium and complex tasks (3+ steps)
- Break features into smaller, manageable steps
- Mark tasks in_progress before starting, completed immediately after finishing
- Keep only ONE task in_progress at a time

### Execution

- Complete current task fully before moving to next
- Don't mark tasks completed if there are errors or failures
- Remove stale or irrelevant tasks from the list
- Update task status in real-time as work progresses

## Code Review Standards

When reviewing code, prioritize in this order:

1. **Maintainability**: Code clarity, patterns, conventions
1. **Correctness**: Logic errors, edge cases, error handling
1. **Style**: Formatting, naming (only if significant)
1. **Security**: Secrets, credentials, exposed data
1. **Performance**: Obvious inefficiencies, memory issues

## Error Handling

- Always handle errors explicitly
- Provide helpful error messages with context
- Don't silently fail or swallow errors
- Log errors with enough detail for debugging
- Consider edge cases and invalid inputs
