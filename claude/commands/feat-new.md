---
description: Scaffold a new SMEAC feature request file
argument-hint: <feature-name>
allowed-tools:
  - Write
---

Create a new feature request file at `./docs/features/$1.md` with this SMEAC template:
```markdown
# Feature: $1

## Situation
<!-- What's the current state and why does this need to change? -->
-
-

## Mission
<!-- Clear, measurable objective -->
**Goal:**

**Success criteria:**
-
-

## Execution
<!-- How will this work? -->
**Implementation:**
1. User flow:
2. Files to modify:
3. Key changes:

**Edge cases:** <!-- Optional -->
-

## Administration <!-- Optional -->
<!-- Testing, rollout, monitoring -->
**Test plan:**
-

**Rollout:**
-

## Constraints
<!-- What NOT to do and what to preserve -->
**Must preserve:**
-

**Out of scope:**
-

**Follow patterns:**
-
```

After creating the file, tell me:
1. The file location
2. To edit it and fill in all sections
3. To run `/feat-exec $1` when ready to implement
