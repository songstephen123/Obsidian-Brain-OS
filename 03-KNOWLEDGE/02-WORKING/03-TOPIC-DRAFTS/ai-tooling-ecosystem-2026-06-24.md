---
title: "AI Tooling Ecosystem Snapshot"
date: "2026-06-24"
source: conversation-mining
topics: [tooling, ai-agents, skills, lark]
status: draft
---

# AI Tooling Ecosystem (2026-06-24 Snapshot)

Inventory extracted from conversation on 2026-06-24. ~119 unique skills across 8 sources.

## Skill Sources

| Source | Count | Location |
|--------|-------|----------|
| Gstack | 33 | `~/.claude/skills/gstack/` → `~/.agents/skills/gstack-*` |
| Lark/飞书 | 19 | `~/.agents/skills/lark-*` |
| Matt Pocock | 18 | `~/.claude/skills/matt-pocock/` |
| mycc (personal) | 16 | `~/mycc/.claude/skills/` |
| 设计/视觉 | 15 | `~/.agents/skills/` |
| Superpowers (Anthropic) | 14 | `~/.claude/plugins/cache/.../superpowers/6.0.3/skills/` |
| 其他工具 | 4 | `~/.agents/skills/` |
| OMC plugin | N (dozens) | `~/.claude/plugins/marketplaces/omc/` |

## Notable Addition: lark-channel-bridge

Installed 2026-06-24, v0.3.1. Node.js CLI at `/opt/homebrew/bin/lark-channel-bridge`.

Capabilities:
- Bridges Lark/飞书 messages to local Claude Code / Codex CLI
- Streaming cards: text + tool calls render in 飞书 in real time
- Session isolation per chat/topic/document comment
- Multi-workspace: `/cd` to switch projects, `/ws` to save
- Image/file forwarding to local agent
- launchd-managed background service

This enables mobile-to-agent interaction: send a 飞书 message → Claude Code executes locally.

## Orchestration Layer

OMC (oh-my-claudecode) provides multi-agent orchestration with workflows: autopilot, ralph, ultrawork, team, pipeline. Agent roles include: explore, analyst, planner, architect, debugger, executor, deep-executor, verifier, quality-reviewer, security-reviewer, code-reviewer, test-engineer, build-fixer, designer, writer, qa-tester, scientist, document-specialist, critic.

MCP providers: Codex (OpenAI gpt-5.3-codex) and Gemini (gemini-3-pro-preview).
