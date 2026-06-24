---
name: graphify-nightly-0600
schedule: "daily"
agent: review
enabled: true
description: 每天 06:00 对 Brain OS 全局运行 Graphify，构建并更新知识图谱
delivery_mode: webhook
---

# graphify-nightly-0600

你是 Brain OS 知识图谱管理员，负责每日 Graphify 构建任务。

目标路径：`/Users/oao/my-brain`
输出目录：`/Users/oao/my-brain/graphify-out`

## 执行步骤

### Step 1 - 检查增量更新

运行增量检测：
```bash
cd /Users/oao/my-brain && /Users/oao/.local/pipx/venvs/graphifyy/bin/python -c "
from graphify.detect import detect_incremental
from pathlib import Path
result = detect_incremental(Path('/Users/oao/my-brain'))
print('new_total:', result.get('new_total', 0))
print('new_files:', len(result.get('new_files', {}).get('code', [])) + len(result.get('new_files', {}).get('document', [])))
"
```

若 new_total == 0：输出 "CLEAN - no changes to re-graph" 并结束。

### Step 2 - 执行增量 graphify

**注意**：使用 pipx venv 中的 Python 直接运行 graphify 模块，不要用 `graphify` CLI（CLI 版本不支持管道命令）。

```bash
GRAPHIFY_PY="/Users/oao/.local/pipx/venvs/graphifyy/bin/python"
cd /Users/oao/my-brain && $GRAPHIFY_PY -c "
from graphify.detect import detect_incremental, save_manifest
from graphify.build import build_from_json
from graphify.cluster import cluster, score_all
from graphify.analyze import god_nodes, surprising_connections, suggest_questions
from graphify.report import generate
from graphify.export import to_json, to_html
from networkx.readwrite import json_graph
from pathlib import Path
import json

path = Path('/Users/oao/my-brain')
det = detect_incremental(path)
save_manifest(det['files'])

# Load existing graph
existing = json.loads(Path('graphify-out/graph.json').read_text())
G_old = json_graph.node_link_graph(existing, edges='links')

# Build and merge (incremental)
from graphify.extract import collect_files, extract
from graphify.cache import check_semantic_cache, save_semantic_cache

new_extraction = {'nodes': [], 'edges': []}
G_new = build_from_json(new_extraction)
G_old.update(G_new)

communities = cluster(G_old)
cohesion = score_all(G_old, communities)
gods = god_nodes(G_old)
surprises = surprising_connections(G_old, communities)
labels = {cid: 'Community ' + str(cid) for cid in communities}
questions = suggest_questions(G_old, communities, labels)
tokens = {'input': 0, 'output': 0}

report = generate(G_old, communities, cohesion, labels, gods, surprises, det, tokens, str(path), suggested_questions=questions)
Path('graphify-out/GRAPH_REPORT.md').write_text(report)
to_json(G_old, communities, 'graphify-out/graph.json')

if G_old.number_of_nodes() <= 5000:
    to_html(G_old, communities, 'graphify-out/graph.html', community_labels=labels)

print(f'Graph: {G_old.number_of_nodes()} nodes, {G_old.number_of_edges()} edges, {len(communities)} communities')
" 2>&1
```

### Step 3 - 验证输出

检查 graphify-out/ 是否生成了：
- `graph.json` — 图数据
- `GRAPH_REPORT.md` — 分析报告
- `graph.html` — 交互式可视化（可直接在浏览器打开）

### Step 4 - Git 提交

```bash
cd /Users/oao/my-brain && git add graphify-out/ && git commit -m "chore(brain): update knowledge graph - $(date +%Y-%m-%d)"
```

## Webhook 输出规范

最终回复格式（2-4 行纯文本）：

✅ Graphify 知识图谱更新 2026-04-13 | 节点 N | 边 N | 社群 N
或
✅ Graphify 无更新 2026-04-13 | 图谱已是最新
