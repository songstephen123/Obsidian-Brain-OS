# Graph Report - /Users/songstephen/my-brain  (2026-05-15)

## Corpus Check
- Large corpus: 285 files · ~174,195 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 508 nodes · 641 edges · 72 communities detected
- Extraction: 72% EXTRACTED · 28% INFERRED · 0% AMBIGUOUS · INFERRED: 182 edges (avg confidence: 0.6)
- Token cost: 0 input · 0 output

## God Nodes (most connected - your core abstractions)
1. `Obsidian Brain OS` - 12 edges
2. `Brain OS CLAUDE.md` - 12 edges
3. `main()` - 11 edges
4. `Conversation Knowledge Flywheel` - 11 edges
5. `Daily Briefing 2026-05-01` - 11 edges
6. `render_transcript_markdown()` - 10 edges
7. `Brain OS Changelog` - 9 edges
8. `Stage 1: Article Integration (02:00)` - 9 edges
9. `upsert_conversation()` - 8 edges
10. `_render_quick_summary()` - 8 edges

## Surprising Connections (you probably didn't know these)
- `Obsidian Brain OS` --semantically_similar_to--> `Obsidian Brain OS Chinese`  [EXTRACTED] [semantically similar]
  README.md → README_CN.md
- `Article Notes Integration SKILL Definition` --references--> `Knowledge Lint Report 2026-04-12`  [INFERRED]
  skills/article-notes-integration/SKILL.md → yes/12-REVIEWS/KNOWLEDGEBASE/lint-2026-04-12.md
- `Project Registry Briefing Layer (yes/ vault)` --semantically_similar_to--> `Project Registry Briefing Layer`  [EXTRACTED] [semantically similar]
  yes/05-PROJECTS/README.md → 05-PROJECTS/README.md
- `CoPaw Flash 9B LoRA Discussion` --references--> `Obsidian Brain OS`  [EXTRACTED]
  00-INBOX/ai-conversations/2026-04-12/claude_songstephen_基础模型是这个：CoPaw Flash 9B.md → README.md
- `Brain OS CLAUDE.md` --references--> `Brain OS Agent Config`  [EXTRACTED]
  CLAUDE.md → AGENTS.md

## Hyperedges (group relationships)
- **Nightly Pipeline 4-Stage Flow** —  [EXTRACTED 1.00]
- **Commit Patrol Path to Working State** —  [INFERRED 0.80]
- **CoPaw Flash 9B LoRA Deployment Ecosystem** —  [INFERRED 0.80]
- **** — article-integration-report-2026-05-10_article-integration, conversation-mining-report-2026-05-10_conversation-mining, amplifier-report-2026-05-10_knowledge-flywheel-amplifier [EXTRACTED 1.00]
- **** — degraded-volume-not-mounted_recurring-issue, conversation-mining-report-2026-05-10_conversation-mining, conversation-mining-report-2026-04-30_nexus4cc-tailscale [INFERRED 0.85]
- **** — architecture_nightly-pipeline, openclaw-setup_cron-config, skills-guide_knowledge-flywheel-amplifier [INFERRED 0.80]
- **Nightly Pipeline Three-Stage Processing Chain** — nightly-pipeline_article-integration, nightly-pipeline_conversation-mining, nightly-pipeline_knowledge-amplification [INFERRED]
- **Brain OS Four-Agent Team Division** — agents_main-agent, agents_writer-agent, agents_chronicle-agent, agents_review-agent [INFERRED]
- **Three-Layer Context Access Control (KNOWLEDGE > WORK > PERSONAL)** — zh_personal-context-guide_three-layer-context, zh_personal-context-guide_06-personal-docs, zh_personal-context-guide_07-work-context, knowledge-architecture_reading-layer [INFERRED]
- **Nightly Knowledge Pipeline Stage Sequence** — knowledge-lint-weekly_knowledge-lint, article-notes-integration-nightly_article-integration, conversation-knowledge-mining-nightly_conversation-mining, knowledge-flywheel-amplifier-nightly_knowledge-flywheel, daily-knowledge-graph-canvas-0500_knowledge-graph-canvas [EXTRACTED 1.00]
- **Brain-Reminders Bidirectional Sync Loop** — brain-to-reminders-0730_brain-to-reminders, reminders-to-brain-2100_reminders-to-brain, apple-reminders_apple-reminders-entity, todo-backlog_todo-backlog-entity [INFERRED 0.85]
- **Personal Ops Daily Cycle** — personal-ops-morning-brief_morning-brief, personal-ops-todo-reminder-1500_todo-reminder-1500, personal-ops-todo-reminder-2000_todo-reminder-2000, knowledgebase-commit-patrol-30m_commit-patrol, todo-backlog_todo-backlog-entity, daily-briefing_daily-briefing-entity [INFERRED 0.80]
- **** — brainstorming_CollaborativeDesign, writing-plans_ImplementationPlanning, planning-with-files_PlanningWithFiles [INFERRED 0.80]
- **** — teach-impeccable_DesignContextSetup, normalize_DesignSystemNormalization, distill_SimplificationDesign, polish_QualityPolishPass, critique_DesignCritique [INFERRED 0.75]
- **** — writing-skills_WritingSkillsMeta, writing-skills-testing_TestingSkillsWithSubagents, writing-skills-persuasion_PersuasionPrinciples, writing-skills-anthropic_AnthropicBestPractices [INFERRED 0.85]
- **** —  [EXTRACTED 1.00]
- **** —  [EXTRACTED 1.00]
- **** —  [EXTRACTED 1.00]
- **Split Nightly Knowledge Pipeline Stages** — knowledge-flywheel-amplifier_SplitPipeline, conversation-knowledge-flywheel_ConversationKnowledgeFlywheel, knowledge-flywheel-amplifier_KnowledgeFlywheelAmplifier [EXTRACTED 1.00]
- **Personal Ops Reference Stack** — personal-ops-driver_PersonalOpsDriver, operating-model_OperatingModel, personal-ops-philosophy_HuaxiaWisdom, personal-priority-rules_PriorityRules, inbox-and-ops-layering_InboxOpsLayering, reference-map_ReferenceMap [EXTRACTED 1.00]
- **Timesheet Output Backend Options** — daily-timesheet_DailyTimesheet, daily-timesheet_DingTalkBitable, daily-timesheet_FeishuBitable [EXTRACTED 1.00]
- **nightly-pipeline-article-stage** — article-notes-integration-skill_article-notes-integration, nightly-runbook_nightly-runbook, example-article-note_article-note, example-nightly-digest_nightly-digest, lint-2026-04-12_knowledge-lint-report, 03-KNOWLEDGE-README_knowledge-base [EXTRACTED 1.00]
- **daily-ops-cockpit-flow** — todo-backlog_todo-backlog, example-daily-brief_daily-brief-example, daily-brief-template_daily-brief, 00-INBOX-README_inbox, 07-WORK-CONTEXT-README_work-context [EXTRACTED 1.00]
- **template-driven-knowledge-lifecycle** — templates-README_templates-directory, article-note-template_article-note-template, project-brief-template_project-brief-template, example-article-note_article-note, 05-PROJECTS-README_project-registry, 03-KNOWLEDGE-README_knowledge-base [INFERRED 0.85]
- **INBOX → Daily Brief → Weekly Plan → Monthly Milestones triage pipeline** — todo-backlog_Concept, daily-brief-template_Concept, 本周排期_W20, 月度里程碑_202605 [INFERRED 0.85]
- **Nightly digest processes INBOX items into knowledge base via 3-layer architecture** — inbox_Concept, nightly-digest_Concept, knowledge_3layer_Concept [INFERRED 0.80]
- **Context compression appears as both an active PR decision point and an extracted knowledge pattern** — PR47_ContextCompression, context-compression-pattern_Concept, example-article-note_PKM [INFERRED 0.70]

## Communities

### Community 0 - "Community 0"
Cohesion: 0.07
Nodes (43): Brain OS Agent Config, Brain OS Changelog, Brain OS CLAUDE.md, Obsidian Brain OS Chinese, Obsidian Brain OS, Apple Reminders Integration, brain-to-reminders.sh, Knowledgebase Commit Patrol (+35 more)

### Community 1 - "Community 1"
Cohesion: 0.08
Nodes (30): AGENTS.md Three-Layer Classification (Slim/Rotate/Delete), Token Optimization via On-Demand Loading, Workspace File Convention (Root Whitelist), Main Agent (Orchestrator), MVP to Full Agent Progression, Writer Agent (Knowledge Base Writer), Article Note Lifecycle (pending/integrated/archived), Domain Knowledge Card Format (+22 more)

### Community 2 - "Community 2"
Cohesion: 0.09
Nodes (28): Custom Zone — User-Defined Structure, NotesMiner Side Project, PR #47 Context Compression, Article Note Template, Atomic Notes with Rich Metadata, Brain OS 5-Week Review, Context Compression Before Retrieval Pattern, Conversation Mining Degraded (Volume Not Mounted) (+20 more)

### Community 3 - "Community 3"
Cohesion: 0.16
Nodes (24): _append_section(), _append_text_block(), build_search_entry(), build_subagent_index(), clean_project_label(), extract_command_mentions(), extract_file_mentions(), extract_signal_mentions() (+16 more)

### Community 4 - "Community 4"
Cohesion: 0.16
Nodes (23): _build_search_index(), _build_transcript_stem(), _clean_metadata_text(), _content_hash(), _default_markdown_dir(), export_antigravity(), export_claude(), export_codex() (+15 more)

### Community 5 - "Community 5"
Cohesion: 0.13
Nodes (24): Apple Reminders Integration, Article Notes Integration Nightly, Brain to Reminders 0730, Chronicle Agent Every 2h, Conversation Knowledge Flywheel Nightly (deprecated), Conversation Knowledge Mining Nightly, Cron Configuration Examples, Daily Briefing (+16 more)

### Community 6 - "Community 6"
Cohesion: 0.14
Nodes (22): Inbox Unified Capture Zone, Knowledge Base Three-Layer Architecture, Custom Zone (User-Defined Structure), Project Registry Briefing Layer (yes/ vault), Project Registry Briefing Layer, Work Context Accumulator, Article Note Template, Article Notes Integration Skill (+14 more)

### Community 7 - "Community 7"
Cohesion: 0.21
Nodes (19): _append_message(), _clean_text(), _collect_brain_artifacts(), _decode_value(), _extract_artifact_heading(), _extract_conversations_from_traj(), _extract_json_objects(), _extract_messages_from_chunk() (+11 more)

### Community 8 - "Community 8"
Cohesion: 0.18
Nodes (17): _clean_text(), decode_project_name(), _extract_assistant_text(), extract_conversation(), _extract_user_text(), find_sessions_by_date(), format_conversation(), _is_noise() (+9 more)

### Community 9 - "Community 9"
Cohesion: 0.2
Nodes (16): _clean_text(), extract_conversation(), _extract_from_history(), find_sessions_by_date(), format_conversation(), _is_system_noise(), load_history_for_session(), load_thread_titles() (+8 more)

### Community 10 - "Community 10"
Cohesion: 0.14
Nodes (17): Brain OS Manager Role, Conversation Knowledge Flywheel, Conversation Knowledge Flywheel Nightly Runbook, NotebookLM Reinforcement Protocol, 05-PROJECTS Project Routing, QMD Hybrid Recall Engine, Surveillance Scan Spec, Writer-Agent Role (+9 more)

### Community 11 - "Community 11"
Cohesion: 0.12
Nodes (16): AI Slop Detection, Holistic Design Critique, Humanizer README, Humanizer WARP.md Developer Guide, 24 AI Writing Patterns, Humanizer: Remove AI Writing Patterns, Adding Personality and Soul to Writing, Wikipedia Signs of AI Writing (+8 more)

### Community 12 - "Community 12"
Cohesion: 0.24
Nodes (13): Article Notes Integration, Brain OS, Claude Code Skills Installation, codebase-to-course Skill, Conversation Mining, Daily Briefing 2026-05-01, Decision Queue, HyperFrames Project (+5 more)

### Community 13 - "Community 13"
Cohesion: 0.18
Nodes (12): Chronicle Agent (Historian), Brain OS Definition (AI-Augmented Personal Context System), Three-Layer Knowledge Architecture, Brain OS Chinese Documentation Index, Brain OS Design Principles, Brain OS System Map (Input/Context/Knowledge/Support/Config), Chronicle Agent (Silent Channel Historian), Physical Separation Solves Knowledge Chaos (+4 more)

### Community 14 - "Community 14"
Cohesion: 0.29
Nodes (12): Brain Methodology Migration Candidates, Brain OS Installer, Socratic Dialogue Installation Method, 00-INBOX / 01-PERSONAL-OPS Layering Scheme, Personal Ops Operating Model v1, Single Source of Truth (todo-backlog.md), Personal Ops Status Model, Personal Ops Driver (+4 more)

### Community 15 - "Community 15"
Cohesion: 0.22
Nodes (11): Knowledge Flywheel Amplifier Pipeline Stage, Nightly Pipeline Architecture, Article Integration Pipeline Stage, Chronicle Agent (Historian), Conversation Mining Pipeline Stage, Recurring Degraded Mode: External Volume Not Mounted, OpenClaw Cron Configuration, Article Notes Integration Skill (+3 more)

### Community 16 - "Community 16"
Cohesion: 0.24
Nodes (11): Skillshare Security Audit, Skillshare Backup and Restore, Skillshare Extras Management, Skillshare Install/Update/Uninstall/New, Skillshare Operation Log, Skillshare Security Audit System, Skillshare Status and Inspection Commands, Skillshare Sync/Collect/Push/Pull (+3 more)

### Community 17 - "Community 17"
Cohesion: 0.2
Nodes (10): UX Writing Clarity, Progressive Disclosure, Simplification by Distillation, Bite-Sized Task Granularity, TDD Task Structure, Anthropic Skill Authoring Best Practices, Evaluation-Driven Skill Development, Progressive Disclosure Pattern (+2 more)

### Community 18 - "Community 18"
Cohesion: 0.27
Nodes (10): Context Engineering for AI Agents, Deep Research Skill, Planning with Files Examples, Manus (AI Agent Company), PESTLE Analysis Framework, Planning with Files Skill, Manus Context Engineering Principles, Research Frameworks and Methodologies (+2 more)

### Community 19 - "Community 19"
Cohesion: 0.25
Nodes (8): Spacing System, Visual Rhythm, Design System Component Extraction, Reusable Pattern Identification, Design System Normalization, Design Tokens, .impeccable.md Design Context File, Teach Impeccable Design Context Setup

### Community 20 - "Community 20"
Cohesion: 0.29
Nodes (7): Agora Multi-Agent Governance Framework, Agora Multi-Agent Governance Framework, GitHub Issues/Projects Integration, Lightweight Project Registry (05-PROJECTS), Linear Issue Tracking, Project Brief Format, Brain OS-Agora Integration Pattern

### Community 21 - "Community 21"
Cohesion: 0.33
Nodes (7): Brain OS Release Skill, Observer Learnings Index Schema, Observer Self-Evolution Skill, PII Scan (check-pii.sh), Observer Daily Iteration Plan Template, Observer Recurrence Map, Semantic Versioning

### Community 22 - "Community 22"
Cohesion: 0.53
Nodes (4): build_html(), _json_for_html_script(), main(), run_export()

### Community 23 - "Community 23"
Cohesion: 0.53
Nodes (4): combineGraphs(), extractDotBlocks(), main(), renderToSvg()

### Community 24 - "Community 24"
Cohesion: 0.47
Nodes (5): build_mapping(), main(), parse_frontmatter(), Extract YAML frontmatter fields we care about (project_ref, aliases)., Return {alias_lower: (project_ref, brief_path)} for all projects.

### Community 25 - "Community 25"
Cohesion: 0.47
Nodes (6): CoPaw-Flash-9B Model, CoPaw-Flash-9B-DataAnalyst-LoRA, mlx-lm Apple MLX Toolkit, omlx MLX Framework, CoPaw Flash 9B LoRA Discussion, CoPaw Flash 9B Subagent Discussion

### Community 26 - "Community 26"
Cohesion: 0.7
Nodes (4): infer_agent(), infer_project(), infer_title(), main()

### Community 27 - "Community 27"
Cohesion: 0.4
Nodes (5): Collaborative Brainstorming Design, Design Approval Hard Gate, Brainstorming to Writing-Plans Transition, Plan Execution Handoff, Writing Implementation Plans

### Community 28 - "Community 28"
Cohesion: 0.5
Nodes (5): Daily Timesheet, DingTalk AI Table Backend, Feishu Bitable Backend, Git Commit Scanning for Timesheet, Milestones File Format (OKR)

### Community 29 - "Community 29"
Cohesion: 0.67
Nodes (3): main(), Generate speech from text using edge-tts., speak()

### Community 30 - "Community 30"
Cohesion: 0.67
Nodes (3): main(), Transcribe audio file using faster-whisper., transcribe()

### Community 31 - "Community 31"
Cohesion: 0.5
Nodes (4): Cross-Source Merge (Partial), Codebase-to-Course Skill Discovery, Nexus4CC + Tailscale Mobile Claude Code Pattern, Claude Code Skill Installation Pitfall

### Community 32 - "Community 32"
Cohesion: 0.5
Nodes (4): edge-tts, English Tutor Skill, faster-whisper, English Tutor Voice Reference

### Community 33 - "Community 33"
Cohesion: 1.0
Nodes (3): Fish Shell, Starship Prompt Theme, Starship Fish Theme Setup

### Community 34 - "Community 34"
Cohesion: 0.67
Nodes (3): RPA vs iPad Hosting Mode, 企微托管运营模式, 企微运营及激励模式介绍

### Community 35 - "Community 35"
Cohesion: 0.67
Nodes (3): Three-Layer Knowledge Architecture, Obsidian Plugin Configuration, Three-Layer Context Architecture (06/07)

### Community 36 - "Community 36"
Cohesion: 0.67
Nodes (3): Vault Setup (Clone + Configure), Obsidian App, OpenClaw Platform

### Community 37 - "Community 37"
Cohesion: 0.67
Nodes (3): Manus (AI Agent Company), Planning with Files Examples, Manus Context Engineering Principles

### Community 38 - "Community 38"
Cohesion: 0.67
Nodes (3): Manus-Style Working Memory, task_plan.md Template, 3-File Pattern

### Community 39 - "Community 39"
Cohesion: 0.67
Nodes (3): Cross-Tool Skill Synchronization (50+ Tools), Skill Sync and Management, Skillshare CLI

### Community 40 - "Community 40"
Cohesion: 1.0
Nodes (2): Modular Installation Profiles, Installation Profiles (Knowledge/Ops/Full)

### Community 41 - "Community 41"
Cohesion: 1.0
Nodes (2): No-op Pipeline Behavior is Normal, No-op Pipeline Explanation (Chinese)

### Community 42 - "Community 42"
Cohesion: 1.0
Nodes (2): First Week Onboarding Plan, First Week Onboarding Plan (Chinese)

### Community 43 - "Community 43"
Cohesion: 1.0
Nodes (2): agent-reach Skill (Cross-Platform Content Fetch), Main Agent Multimodal Requirement

### Community 44 - "Community 44"
Cohesion: 1.0
Nodes (2): notebooklm-py CLI, notebooklm-py CLI Tool

### Community 45 - "Community 45"
Cohesion: 1.0
Nodes (2): Core Web Vitals, Web Performance Optimization

### Community 46 - "Community 46"
Cohesion: 1.0
Nodes (2): Animation Performance, Rendering Performance

### Community 47 - "Community 47"
Cohesion: 1.0
Nodes (2): Error Message Writing, Microcopy Guidelines

### Community 48 - "Community 48"
Cohesion: 1.0
Nodes (2): Interaction States Checklist, Micro-interactions and Transitions

### Community 49 - "Community 49"
Cohesion: 1.0
Nodes (2): Claude Search Optimization (CSO), Writing Skills Meta-Skill

### Community 50 - "Community 50"
Cohesion: 1.0
Nodes (0): 

### Community 51 - "Community 51"
Cohesion: 1.0
Nodes (0): 

### Community 52 - "Community 52"
Cohesion: 1.0
Nodes (0): 

### Community 53 - "Community 53"
Cohesion: 1.0
Nodes (1): Hello Session

### Community 54 - "Community 54"
Cohesion: 1.0
Nodes (1): Capture Once Process Forever Philosophy

### Community 55 - "Community 55"
Cohesion: 1.0
Nodes (1): Knowledge Lint Health Check 2026-04-20

### Community 56 - "Community 56"
Cohesion: 1.0
Nodes (1): Review Agent (Auditor)

### Community 57 - "Community 57"
Cohesion: 1.0
Nodes (1): Skill File Structure (SKILL.md + references + scripts + templates)

### Community 58 - "Community 58"
Cohesion: 1.0
Nodes (1): Obsidian Core Plugins (Dataview, Templater, Calendar)

### Community 59 - "Community 59"
Cohesion: 1.0
Nodes (1): Cron Job Delivery Configuration (Webhook/Channel/Silent)

### Community 60 - "Community 60"
Cohesion: 1.0
Nodes (1): Observer Daily 0001

### Community 61 - "Community 61"
Cohesion: 1.0
Nodes (1): Daily Timesheet 1730

### Community 62 - "Community 62"
Cohesion: 1.0
Nodes (1): Planning with Files

### Community 63 - "Community 63"
Cohesion: 1.0
Nodes (1): Saint-Exupery Perfection Principle

### Community 64 - "Community 64"
Cohesion: 1.0
Nodes (1): Spatial Design and Layout

### Community 65 - "Community 65"
Cohesion: 1.0
Nodes (1): Degrees of Freedom in Skills

### Community 66 - "Community 66"
Cohesion: 1.0
Nodes (1): Agent Reach Multi-Platform Internet Access

### Community 67 - "Community 67"
Cohesion: 1.0
Nodes (1): 13+ Platform Integration Channels

### Community 68 - "Community 68"
Cohesion: 1.0
Nodes (1): Skillshare Init Command

### Community 69 - "Community 69"
Cohesion: 1.0
Nodes (1): Skillshare CLI Tool

### Community 70 - "Community 70"
Cohesion: 1.0
Nodes (1): Deadline Summary

### Community 71 - "Community 71"
Cohesion: 1.0
Nodes (1): songstephen

## Knowledge Gaps
- **178 isolated node(s):** `基于 messages 生成内容哈希，用于判断会话是否有变化`, `插入或更新会话。返回 True 表示内容有变化（需要重新 materialize），False 表示未变化。`, `Materialize transcript markdown files.      Args:         dirty_ids: 如果非 None，只重`, `导出时生成轻量搜索索引 search_index.json`, `从 conversation 中提取搜索索引条目，用于轻量快速搜索。` (+173 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 40`** (2 nodes): `Modular Installation Profiles`, `Installation Profiles (Knowledge/Ops/Full)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 41`** (2 nodes): `No-op Pipeline Behavior is Normal`, `No-op Pipeline Explanation (Chinese)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 42`** (2 nodes): `First Week Onboarding Plan`, `First Week Onboarding Plan (Chinese)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 43`** (2 nodes): `agent-reach Skill (Cross-Platform Content Fetch)`, `Main Agent Multimodal Requirement`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 44`** (2 nodes): `notebooklm-py CLI`, `notebooklm-py CLI Tool`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 45`** (2 nodes): `Core Web Vitals`, `Web Performance Optimization`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 46`** (2 nodes): `Animation Performance`, `Rendering Performance`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 47`** (2 nodes): `Error Message Writing`, `Microcopy Guidelines`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 48`** (2 nodes): `Interaction States Checklist`, `Micro-interactions and Transitions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 49`** (2 nodes): `Claude Search Optimization (CSO)`, `Writing Skills Meta-Skill`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 50`** (1 nodes): `convs.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 51`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 52`** (1 nodes): `render-writer-package.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 53`** (1 nodes): `Hello Session`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 54`** (1 nodes): `Capture Once Process Forever Philosophy`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 55`** (1 nodes): `Knowledge Lint Health Check 2026-04-20`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 56`** (1 nodes): `Review Agent (Auditor)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 57`** (1 nodes): `Skill File Structure (SKILL.md + references + scripts + templates)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 58`** (1 nodes): `Obsidian Core Plugins (Dataview, Templater, Calendar)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 59`** (1 nodes): `Cron Job Delivery Configuration (Webhook/Channel/Silent)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 60`** (1 nodes): `Observer Daily 0001`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 61`** (1 nodes): `Daily Timesheet 1730`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 62`** (1 nodes): `Planning with Files`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 63`** (1 nodes): `Saint-Exupery Perfection Principle`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 64`** (1 nodes): `Spatial Design and Layout`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 65`** (1 nodes): `Degrees of Freedom in Skills`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 66`** (1 nodes): `Agent Reach Multi-Platform Internet Access`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (1 nodes): `13+ Platform Integration Channels`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 68`** (1 nodes): `Skillshare Init Command`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 69`** (1 nodes): `Skillshare CLI Tool`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 70`** (1 nodes): `Deadline Summary`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 71`** (1 nodes): `songstephen`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Stage 1: Article Integration (02:00)` connect `Community 1` to `Community 13`?**
  _High betweenness centrality (0.005) - this node is a cross-community bridge._
- **Why does `Obsidian Brain OS` connect `Community 0` to `Community 25`?**
  _High betweenness centrality (0.005) - this node is a cross-community bridge._
- **Are the 10 inferred relationships involving `main()` (e.g. with `load_index()` and `save_index()`) actually correct?**
  _`main()` has 10 INFERRED edges - model-reasoned connections that need verification._
- **What connects `基于 messages 生成内容哈希，用于判断会话是否有变化`, `插入或更新会话。返回 True 表示内容有变化（需要重新 materialize），False 表示未变化。`, `Materialize transcript markdown files.      Args:         dirty_ids: 如果非 None，只重` to the rest of the system?**
  _178 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.07 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.09 - nodes in this community are weakly interconnected._