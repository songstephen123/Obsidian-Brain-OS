---
id: claude-20260408-21a00cc2
source: claude
date: 2026-04-08
session_id: agent-af8951b204630c4e2
viewer_id: claude-20260408-21a00cc2
transcript_version: 2
project: Users/songstephen
---

# Thoroughly explore the codebase at /tmp/

## Session

- Source: claude
- Date: 2026-04-08
- Project: `Users/songstephen`
- Session ID: `agent-af8951b204630c4e2`

## Quick Summary

- Final answer: Now I have a thorough understanding of the codebase. Here is my comprehensive analysis: 1. What is this project? graphify is an AI coding assistant skill (for Claude Code, Codex, OpenCode, OpenClaw, Factory Droid) that turns any folder of code, docs, papers, or images into a queryable knowledge graph . It is published on PyPI as graphifyy (the graphify name was temporarily unavailable) and is installed via pip install graphifyy && graphify install. The core value proposition (from the README): "Understand a codebase faster. Find the 'why' behind architectural decisions." it answers the problem Andrej Karpathy faces with his /raw folder containing papers, tweets, screenshots, and notes. The tool shows what is connected that you did not know was connected. Key numbers: 71.5x fewer tokens pe…

## Files Mentioned

- None detected

## Commands Mentioned

- None detected

## Signals

- 6. Clever Patterns, Interesting Design Decisions, Notable Features

## Transcript

### User

Thoroughly explore the codebase at /tmp/graphify to understand what it is, what it does, and how it works.

I need to know:
1. What is this project? (read README, pyproject.toml, main entry points)
2. What is the overall architecture? (key files, folders, components)
3. What are the main "actors" (modules, services, components) and their responsibilities?
4. What is the primary user journey / how does it work end-to-end?
5. What tech stack is used and why?
6. Are there any clever patterns, interesting design decisions, or notable features?
7. What would a learner find interesting or useful about this codebase?
8. Read README.zh-CN.md for the Chinese version of key content

Be very thorough — read the README, explore the directory structure, read key source files. I need enough understanding to build an interactive course about this codebase.

### Claude

I'll thoroughly explore the codebase at /tmp/graphify. Let me start by examining the directory structure and key files.

### Claude

Let me read the key documentation files and explore the project structure.

### Claude

Now let me explore the main source code directory structure and read key source files.

### Claude

Let me read the core pipeline modules to understand the architecture.

### Claude

Let me continue reading key modules and the skill files.

### Claude

Let me continue reading more key files to complete my understanding.

### Claude

Let me read the remaining modules and look at a worked example output.

### Claude

Let me also check the tests directory and a few more files.

### Claude

Let me also read the wiki.py and the extract.py (which is very large) to get a fuller picture.

### Claude

Now I have a thorough understanding of the codebase. Here is my comprehensive analysis:

---

## 1. What is this project?

**graphify** is an AI coding assistant skill (for Claude Code, Codex, OpenCode, OpenClaw, Factory Droid) that turns any folder of code, docs, papers, or images into a **queryable knowledge graph**. It is published on PyPI as `graphifyy` (the `graphify` name was temporarily unavailable) and is installed via `pip install graphifyy && graphify install`.

The core value proposition (from the README): *"Understand a codebase faster. Find the 'why' behind architectural decisions."* - it answers the problem Andrej Karpathy faces with his `/raw` folder containing papers, tweets, screenshots, and notes. The tool shows what is connected that you did not know was connected.

**Key numbers:**
- 71.5x fewer tokens per query vs reading raw files (on a 52-file mixed corpus of Karpathy repos + papers + images)
- 19 languages supported via tree-sitter AST extraction
- Fully multimodal: code, PDFs, markdown, screenshots, diagrams (via Claude vision)

---

## 2. Overall Architecture

The project has a **linear pipeline** with clean separation between stages. All communication is through plain Python dicts and NetworkX graphs - no shared state.

```
detect()  →  extract()  →  build_graph()  →  cluster()  →  analyze()  →  report()  →  export()
```

Each stage is a single function in its own module. The pipeline is executed in two passes:

**Pass 1 (deterministic, free):** AST extraction via tree-sitter for code files - classes, functions, imports, call graphs, docstrings, rationale comments (`# NOTE:`, `# WHY:`, `# HACK:`, `# IMPORTANT:`).

**Pass 2 (LLM, costs tokens):** Claude subagents extract concepts, relationships, and design rationale from docs, papers, and images in parallel.

Results are merged into a NetworkX graph, clustered with Leiden community detection, and exported as interactive HTML, queryable JSON, and a plain-language GRAPH_REPORT.md audit report.

---

## 3. Key Actors (Modules) and Their Responsibilities

| Module | Responsibility |
|--------|---------------|
| **`detect.py`** | File discovery, type classification (code/doc/paper/image), `.graphifyignore` support, incremental change detection via file mtime manifest, corpus health checks |
| **`extract.py`** | Deterministic AST extraction via tree-sitter for 19 languages. Returns `{nodes, edges}` dicts. Handles call-graph second pass for INFERRED edges. Language-specific configs via `LanguageConfig` dataclass |
| **`build.py`** | Merges multiple extraction results into a single NetworkX graph. Node deduplication at 3 layers: within-file (AST `seen_ids`), between-files (NetworkX idempotence), semantic merge (skill `seen` set) |
| **`cluster.py`** | Leiden community detection (via graspologic, fallback to Louvain). Oversized communities (>25% of graph) are split recursively. Returns `{community_id: [node_ids]}` with cohesion scores |
| **`analyze.py`** | God nodes (highest-degree real entities), surprising connections (cross-community edges ranked by composite score), suggested questions (from AMBIGUOUS edges, bridge nodes, isolated nodes) |
| **`report.py`** | Generates `GRAPH_REPORT.md` - the human-readable audit trail with corpus check, summary stats, god nodes, surprising connections, communities, ambiguous edges, knowledge gaps |
| **`export.py`** | Exports to HTML (vis.js interactive graph), JSON (persistent graph), SVG, GraphML (Gephi/yEd), Obsidian vault, Neo4j Cypher, Wikipedia-style wiki |
| **`cache.py`** | SHA256-based per-file cache. `load_cached`/`save_cached` for individual files, `check_semantic_cache`/`save_semantic_cache` for batch semantic results |
| **`ingest.py`** | Fetches URLs (tweets via oEmbed, arXiv papers, generic web pages, PDFs/images) and saves as annotated markdown with YAML frontmatter |
| **`security.py`** | URL validation (http/https only, SSRF protection via private IP blocking), safe fetch with size caps, graph path validation (must stay inside `graphify-out/`), label sanitization (XSS prevention) |
| **`validate.py`** | Schema validation for extraction JSON before graph assembly. Enforces required fields and valid enumerations |
| **`watch.py`** | Filesystem watcher via `watchdog`. Code changes trigger instant AST-only rebuild. Doc/image changes write a `needs_update` flag |
| **`hooks.py`** | Git hook integration (`post-commit` and `post-checkout`) for automatic graph rebuilding |
| **`serve.py`** | MCP stdio server exposing graph query tools. BFS/DFS traversal, node scoring, subgraph-to-text rendering with token budget |
| **`wiki.py`** | Generates Wikipedia-style markdown wiki from graph: `index.md` entry point + one article per community + one per god node |
| **`benchmark.py`** | Token reduction benchmark: measures corpus tokens vs graph query tokens |
| **`__main__.py`** | CLI entry point handling: install/uninstall for all platforms, query, benchmark, hook management, always-on assistant instructions |
| **`skill.md`** | The Claude Code skill definition - orchestrates the full pipeline via Agent tool subcalls |

---

## 4. Primary User Journey / End-to-End Flow

1. **User types `/graphify ./raw`** in Claude Code (or `$graphify` on Codex)
2. **Skill reads the skill.md** and follows the steps:
   - Ensures `graphifyy` is installed
   - Runs `detect()` to find all files, classify by type, check corpus size
   - If corpus is very large (>2M words or >200 files), asks user which subfolder
   - Runs **Part A (AST extraction)** and **Part B (semantic extraction)** in parallel:
     - Part A: tree-sitter parses code files, extracts classes/functions/imports/calls/rationale
     - Part B: Agent tool dispatches parallel subagents to extract concepts/relationships from docs/papers/images using Claude
   - Merges results via `build()`, clusters via `cluster()`, analyzes via `analyze()`
   - Exports to `graphify-out/`:
     - `graph.json` - persistent graph
     - `graph.html` - interactive vis.js visualization
     - `GRAPH_REPORT.md` - human-readable audit
     - `cache/` - SHA256 cache for incremental updates

3. **User can then:**
   - Open `graph.html` to explore the interactive graph
   - Read `GRAPH_REPORT.md` for god nodes, surprising connections, suggested questions
   - Run `/graphify query "what connects attention to the optimizer?"` to traverse the graph
   - Run `/graphify path "DigestAuth" "Response"` to find shortest path
   - Run `/graphify add https://arxiv.org/abs/1706.03762` to ingest new content
   - Run `graphify hook install` for automatic rebuilding on git commits
   - Run `graphify claude install` to make Claude always优先 use the graph

---

## 5. Tech Stack and Why

| Component | Choice | Why |
|-----------|--------|-----|
| **Graph storage** | NetworkX | Python-native, no server needed, rich algorithms for community detection, easy serialization |
| **Community detection** | Leiden via graspologic (Louvain fallback) | Leiden produces higher-quality communities than Louvain; fallback ensures no hard dependency |
| **Code parsing** | tree-sitter + 19 tree-sitter language parsers | Deterministic, fast, accurate AST extraction; no LLM needed for code |
| **Visualization** | vis.js (via pyvis or custom HTML) | Interactive web-based graph with search, filtering by community, click-to-explore |
| **Semantic extraction** | Claude (Claude Code), GPT-4 (Codex), or platform model | Uses the platform's own model API; no separate API key needed |
| **URL fetching** | Standard library `urllib` + platform-specific handlers | Avoids heavy dependencies; custom redirect handler for SSRF protection |
| **Optional: Neo4j** | Via generated Cypher txt or direct push | Opt-in for users who want a real graph DB |
| **Optional: PDF** | pypdf | Opt-in for paper extraction |
| **Optional: Office** | python-docx, openpyxl | Opt-in for Word/Excel extraction |
| **Optional: Watch** | watchdog | Opt-in for file watching mode |

**Key design: No server, no Neo4j required by default, no embeddings/vectors.** The graph topology IS the similarity signal.

---

## 6. Clever Patterns, Interesting Design Decisions, Notable Features

### Confidence Labels
Every edge is tagged `EXTRACTED` (found directly in source), `INFERRED` (reasonable deduction with confidence_score 0.0-1.0), or `AMBIGUOUS` (flagged for review). Users always know what was found vs invented.

### Token Benchmark
Every run prints token cost. The 71.5x reduction figure is computed from real runs and printed automatically. This is a trust-building mechanism.

### SHA256 Cache with Atomic Write
`cache.py` uses `os.replace()` for atomic writes: `tmp.write_text()` then `os.replace(tmp, entry)`. This prevents cache corruption on interrupted runs.

### Three-Layer Node Deduplication
1. Within-file (AST `seen_ids` set)
2. Between-files (NetworkX `add_node` idempotence - last write wins)
3. Semantic merge (skill `seen` set before calling `build()`)

### Graph-Topology-Based Clustering (No Embeddings)
Leiden finds communities by edge density. Claude's semantic similarity edges (`semantically_similar_to`, marked `INFERRED`) are already in the graph and directly influence community detection. No separate embedding step or vector DB.

### Hyperedges
Group relationships connecting 3+ nodes that pairwise edges cannot express. Rendered as shaded convex hull regions in the HTML visualization.

### PreToolUse Hook (Claude Code only)
`settings.json` PreToolUse hook fires before every `Glob` and `Grep`, surfacing: *"graphify: Knowledge graph exists. Read graphify-out/GRAPH_REPORT.md for god nodes and community structure before searching raw files."* This is the "always-on" mechanism that makes Claude navigate via graph structure rather than keyword searching.

### Lazy Module Imports
`__init__.py` uses `__getattr__` for lazy imports so `graphify install` works before heavy dependencies (tree-sitter, networkx) are in place.

### .graphifyignore
Same syntax as `.gitignore` - patterns matched against relative paths. Used to exclude `vendor/`, `node_modules/`, etc.

### Rationale Extraction
Comments tagged `# NOTE:`, `# IMPORTANT:`, `# HACK:`, `# WHY:` are extracted as `rationale_for` nodes. The tool captures not just what code does but why it was written that way.

### Security: SSRF Protection
URL validation blocks private/reserved/loopback IPs, cloud metadata endpoints, and re-validates every redirect target via custom `HTTPRedirectHandler`. Graph path validation ensures file reads cannot escape `graphify-out/`.

### Git Hooks for Auto-Rebuild
`post-commit` and `post-checkout` hooks rebuild the graph (AST-only, no LLM) after commits and branch switches. Non-zero exit on failure surfaces errors rather than silently continuing.

### Semantic Cache Grouping
`save_semantic_cache()` groups nodes/edges by `source_file` and saves one cache entry per original file. This enables fine-grained cache invalidation.

### Surprise Score Algorithm
`suggestive_connections` uses a composite score: AMBIGUOUS > INFERRED > EXTRACTED, cross-file-type bonus (code↔paper is more surprising than code↔code), cross-repo bonus, cross-community bonus, peripheral→hub bonus, semantic similarity multiplier (1.5x).

### Community Splitting
Communities larger than 25% of graph nodes are recursively split via a second Leiden pass on the subgraph.

### worked/ Examples
Each worked example directory contains raw inputs and actual outputs (`GRAPH_REPORT.md`, `graph.json`). This lets users verify claims like "71.5x reduction" themselves.

---

## 7. What Would a Learner Find Interesting or Useful

**For someone building an AI agent or RAG system:**
- The two-pass extraction architecture (deterministic AST + LLM semantic) is elegant and cost-effective
- The confidence labeling system is a model for honest, audit-able AI output
- Graph-topology-based clustering without embeddings is a clever cost-saving pattern

**For someone building a developer tool:**
- The PreToolUse hook pattern for making an AI assistant "always-on" with context is powerful
- The skill.md orchestration pattern for using Agent tool as a job queue is instructive
- The platform-specific install logic (Claude Code, Codex, OpenCode, OpenClaw, Factory Droid, Windows) shows how to abstract across AI assistant platforms

**For someone interested in code analysis:**
- The `LanguageConfig` dataclass pattern for adding new language support is clean and extensible
- The call-graph second pass for inferring `calls` edges from text mentions is a clever heuristic
- The rationale extraction (`# NOTE:`, `# WHY:`) is a model for capturing design intent

**For someone building a visualization:**
- The custom vis.js HTML generation with hyperedge rendering as convex hulls is sophisticated
- The community-colored nodes with search/filter sidebar is a well-designed UX

**For someone learning software architecture:**
- The linear pipeline with pure function stages and dict/graph communication is a great example of functional architecture
- The lazy import pattern in `__init__.py` is practical for CLI tools with heavy dependencies
- The security layer (input validation, path guards, SSRF protection) shows how to handle untrusted input

---

## 8. README.zh-CN.md Key Content (Chinese Version)

The Chinese README covers the same content as the English version but emphasizes:

- **为什么需要 graphify**: 解决 Karpathy 的 `/raw` 文件夹问题 - 每次查询 token 消耗可降低 **71.5 倍**，结果跨会话持久保存，明确区分哪些是实际发现的、哪些是合理推断
- **两轮执行**: 第一轮确定性 AST 提取（不需要 LLM），第二轮并行 Claude 子代理处理文档/论文/图片
- **聚类基于图拓扑**：Leiden 按边密度发现社区，不需要 embeddings 或向量数据库
- **置信度标签**: `EXTRACTED` / `INFERRED` / `AMBIGUOUS` - 用户始终知道哪些是找到的、哪些是猜的
- **常驻 hook vs 显式触发**: 常驻 hook 让助手优先看 `GRAPH_REPORT.md`（地图），显式命令让它精确导航
- **Token 基准**: 每次运行自动打印，52 文件混合语料达到 71x+ 压缩
- **隐私**: 代码文件通过 tree-sitter AST 本地处理不外发，只有语义提取阶段调用平台自己的模型 API
