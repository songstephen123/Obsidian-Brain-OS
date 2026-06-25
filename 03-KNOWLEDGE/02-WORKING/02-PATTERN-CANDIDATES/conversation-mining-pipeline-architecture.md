---
id: KB-20260625-001
title: 对话沉淀流水线架构 — 7 步设计与 Minimal Viable Path 降级策略
type: conversation-derived-note
status: active
created_at: 2026-06-25
created_by: codex-main
language: zh-CN
summary: conversation-knowledge-flywheel skill 的完整架构与降级规则——oao 在 2026-06-25 的对话中第一次清晰讲清楚：3 类产出、7 步流水线、QMD 不可用时的 MVP 路径，以及为什么选 B 不选 C。
key_points:
  - conversation-mining 的 3 类产出：可复用知识笔记 / 今日可执行建议 / 候选研究种子
  - 7 步流水线：manifest → group → QMD 召回 → surveillance 快扫 → 人工提炼 → 写入 Brain → 验证可见
  - Minimal Viable Path：QMD 不可用时跳过 Step 3-4，直接读每个 project 最大的几个 transcript
  - 选 B 不选 C 的判断标准：MVP 路径已能产出真正的知识笔记，装 QMD 是精度提升而非功能解锁
project_ref: proj-my-brain
source_transcripts:
  - /Users/oao/brain-transcripts/2026-06-25/claude_oao_看看运行的怎么样了.md
updated_at: 2026-06-25
source_type: internal
content_type: conversation
source_title: 06-25 对话沉淀：流水线架构自我说明
domain:
  - knowledge-management
topic_domain: ai
topic_subdomain: workflow
topic:
  - conversation-mining
  - pipeline-architecture
  - degraded-mode
tags:
  - ai-conversation
  - knowledge-flywheel
  - mvp-path
  - qmd
related_projects: []
related_notes: []
related_notebooks: []
notebooklm_sync: pending
confidence: high
priority: medium
review_status: draft
---

# 对话沉淀流水线架构 — 7 步设计与 Minimal Viable Path 降级策略

## 来源说明

- 日期：2026-06-25
- 项目：my-brain（个人知识系统）
- project_ref：`proj-my-brain`
- transcript：`/Users/oao/brain-transcripts/2026-06-25/claude_oao_看看运行的怎么样了.md`
- 抽取原因：这是 oao 第一次让 Claude 完整解释 conversation-mining skill 的设计，对话本身把架构讲得最清楚——值得作为参考留给未来调试。

## 核心结论

- **三类产出**：
  1. **可复用知识笔记**——决策、方法论、架构边界、踩过的坑 → `03-KNOWLEDGE/` 下笔记
  2. **今日可执行建议**——"昨天你意识到 X，今天可以试试 Y" → nightly-digest + 第二天 morning brief
  3. **候选研究种子**——值得深挖但内部信息不够的主题（默认不自动深研） → research-seed 文件，等人工触发 NotebookLM
- **7 步流水线**（满血形态）：
  ```
  Step 1  build manifest        列昨天所有 transcript
  Step 2  group by project      按项目分组（my-brain / mycc / ...）
  Step 3  QMD 召回              用 QMD 做语义/混合搜索找高价值片段
  Step 4  Surveillance 快扫     轻量模型预筛 P1/P2/P3 优先级
  Step 5  最终提炼              Claude 读候选 + 项目 brief，决定什么沉淀
  Step 6  写入 Brain            落地到知识笔记
  Step 7  验证可见              commit + sync + Obsidian 能看到
  ```
- **Minimal Viable Path**：QMD 不可用时，跳过 Step 3-4，直接 `read the top N largest transcripts per project group directly`——精度下降但功能保住。

## 可复用的方法 / 判断

### 1. 降级规则的优先级是"先保功能，再提精度"

当依赖链有多个 broken point（这里：transcript 路径错 + QMD 缺失），优先修上游（路径）让 MVP 路径能跑通，而不是同时修两个。MVP 能产出真正的知识笔记，已经满足核心诉求；QMD 是精度增强，不是功能开关。

### 2. 变量命名不一致是 silent killer

skill 的 `preflight.sh` 读 `TRANSCRIPT_ROOT`，但用户的 `config.env` 里设的是 `TRANSCRIPT_DIR`——两个不同变量名，preflight 读不到，就回退到默认值（还是原作者机器上的外置硬盘路径）。这类 bug 不会报错，只是默默 degraded。

**规则**：跨脚本的配置变量应该 grep 双向检查，preflight 应该在变量缺失时大声失败而不是静默回退。

### 3. 三层职责分离

- **QMD**：召回（recall），不下真理判断
- **Surveillance**：候选预筛（candidate recall），不写知识
- **Writer-Agent**：正式落地（formal landing），不重新决定选什么

这层分离是 strict 的——recall 层可以 noisy，但不能越界写知识。

## 对当前事项的杠杆点

- 今天最值得继续推进的点：MVP 路径已经在跑（昨天的 06-24 报告 + 今天的 06-25 报告都是 MVP 模式产出）。装 QMD 不是当务之急。
- 可以直接带入 daily briefing 的动作：观察连续 N 天 MVP 模式下的产出质量，再决定何时升级到满血（装 QMD）。

## 可继续研究的问题

1. QMD（markdown 查询工具）到底是什么包？是否值得装？装上后对跨项目主题发现的精度提升有多大？
2. Surveillance 层（轻量快模型 broad scan）在当前 MVP 模式下是否还有替代方案？比如直接用 Claude 内置的 batch scan？
3. 当 transcript 体积大到无法全读时（比如 >50 个/天），MVP 路径会失效——阈值在哪里？

## 原始对话证据

> 这个 skill 到底做什么
> **一句话**：每天凌晨扫你昨天和 AI 的所有对话，把"高价值部分"变成 3 样东西

> skill 明确说：**QMD 不可用时**，跳过 Step 3-4，走简化路径——
> "read the top N largest transcripts per project group directly"
> 意思就是 Claude 直接读每个项目最大的几个 transcript，不用 QMD 做语义搜索。**这就是 option B 修复后能跑通的状态**——精度比满血低（没有向量召回），但能产出真正的知识笔记。

> **B. 修 TRANSCRIPT_ROOT**——把 config.env 里的 TRANSCRIPT_ROOT 指向一个真实存在的路径（比如 ~/brain-transcripts/，让 export-conversations.sh 先把对话倒进去），让 03:00 至少能读到对话原文。

## 后续动作建议

- 暂不装 QMD，观察 MVP 模式连续 7 天的产出质量（每天 1-3 篇知识笔记 vs 0 篇）。
- 如果某天 transcript 数量爆发（比如 >30 个人类对话），重新评估 QMD 优先级。
- 把"preflight 大声失败"作为未来 skill 改进点记下来。
