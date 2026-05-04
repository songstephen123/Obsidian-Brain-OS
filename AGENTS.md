# Brain OS — Personal Knowledge & Ops System

## Overview

Brain OS is your personal knowledge management and operations system. It runs on Obsidian vault + Codex as the AI agent.

**Vault path:** `/Users/songstephen/my-brain`

## Directory Structure

```
my-brain/
├── 00-INBOX/           # Input collection point
│   ├── todo-backlog.md  # Master todo list
│   ├── ai-conversations/
│   ├── web/
│   ├── office/
│   └── ...
├── 01-PERSONAL-OPS/    # Personal operations
│   ├── 01-DAILY-BRIEFS/daily-briefing.md
│   ├── 02-PLANS-AND-SCHEDULES/
│   ├── 03-TODOS-AND-FOLLOWUPS/
│   └── 04-MONTHLY-MILESTONES/
├── 04-SYSTEM/          # System prompts & skills
├── prompts/cron/       # Cron task definitions
└── graphify-out/       # Knowledge graph output
```

## Core Skills (use these directly)

| Skill | Command | Purpose |
|-------|---------|---------|
| personal-ops-driver | `/personal-ops-driver` | Personal task management, triage, reminders |
| article-notes-integration | `/article-notes-integration` | Process web articles into knowledge |
| conversation-knowledge-flywheel | `/conversation-knowledge-flywheel` | Mine AI conversations for insights |
| brain-os-installer | `/brain-os-installer` | Installation guide |

## Daily Workflow

1. **Capture** → Put items into `00-INBOX/`
2. **Process** → Codex reads INBOX, updates `todo-backlog.md`
3. **Execute** → Work through prioritized todos
4. **Reflect** → Nightly pipeline auto-runs at sleep hours

## Cron Tasks (auto-configured)

These run via macOS crontab + Codex CLI:

| Time | Task |
|------|------|
| 07:00 | Morning briefing → `01-PERSONAL-OPS/01-DAILY-BRIEFS/daily-briefing.md` |
| 15:00 | Todo afternoon reminder |
| 20:00 | Todo evening follow-up |
| 30min | Knowledge base commit patrol |
| Mon 05:10 | Weekly plan |
| 1st 06:20 | Monthly milestones |

## Key Files

- **todo-backlog.md** — Single source of truth for all todos
- **daily-briefing.md** — Current day's mission brief
- **当前承诺事项.md** — Active commitments
- **decision-queue.md** — Pending decisions

## Commands

```bash
# Manual trigger any cron task
bash ~/.Codex/scripts/brain-os-cron-wrapper.sh <task-name> <prompt-file>

# Check cron logs
ls /Users/songstephen/my-brain/.cron-logs/

# Check git status
cd /Users/songstephen/my-brain && git status
```

## Agent Behavior Rules

- **Read first** → Check todo-backlog.md and relevant context files before acting
- **Write to correct location** → Follow directory structure above
- **Commit changes** → After writing, run `git add . && git commit`
- **Notify** → macOS notification on task completion
- **Be concise** → Output actionable items, not essays
