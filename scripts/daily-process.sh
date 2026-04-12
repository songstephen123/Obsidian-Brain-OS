#!/bin/bash
# Daily Process - 每日处理脚本
# 对话挖掘 → 收集 → 转换 → 建图谱 → Nightly Pipeline

# 配置
BRAIN_OS="/Users/songstephen/my-brain"
INBOX="$BRAIN_OS/00-INBOX"
CONVERSATION_MINING="$HOME/.claude/skills/conversation-mining"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[$(date +%H:%M:%S)]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║     Brain OS Daily Process - 每日处理                   ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Step 0: 对话挖掘 (conversation-mining)
log "💬 Step 0: 挖掘 AI 对话历史"
if [ -d "$CONVERSATION_MINING" ]; then
  cd "$CONVERSATION_MINING"
  conversation-mining --no-open --days 1 2>&1 | while read line; do
    echo "  $line"
  done

  # 把导出的 Markdown 复制到 INBOX
  TRANSCRIPT_DIR="$CONVERSATION_MINING/exported_conversations/transcripts"
  if [ -d "$TRANSCRIPT_DIR" ]; then
    TODAY_DIR="$INBOX/ai-conversations/$(date +%Y-%m-%d)"
    mkdir -p "$TODAY_DIR"
    cp -n "$TRANSCRIPT_DIR"/*.md "$TODAY_DIR/" 2>/dev/null
    count=$(ls "$TODAY_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -gt 0 ]; then
      log "  已导入 $count 个对话到 INBOX/ai-conversations/"
    fi
  fi
else
  warn "  conversation-mining 未安装，跳过"
fi
echo ""

# 检查 INBOX 是否有内容
file_count=$(find "$INBOX" -type f \( -name "*.md" -o -name "*.docx" -o -name "*.pdf" -o -name "*.pptx" \) 2>/dev/null | wc -l | tr -d ' ')

if [ "$file_count" -eq 0 ]; then
  warn "INBOX 为空，没有需要处理的内容"
  exit 0
fi

info "发现 $file_count 个文件待处理"
echo ""

# Step 1: 收集 (如果有新文件)</parameter>

log "📥 Step 1: 收集文件"
if [ $# -gt 0 ]; then
  "$BRAIN_OS/scripts/collect.sh" "$@"
else
  echo "  (无新文件跳过)"
fi
echo ""

# Step 2: 转换 (markitdown 转换未转换的文件)
log "🔄 Step 2: 格式转换"

# 转换 Office 文档
for f in $(find "$INBOX/office" -type f \( -name "*.docx" -o -name "*.pptx" -o -name "*.doc" -o -name "*.ppt" \) 2>/dev/null); do
  filename=$(basename "$f")
  output="${f%.*}.md"
  if [ ! -f "$output" ]; then
    markitdown "$f" -o "$output" 2>/dev/null
    log "  转换: $filename -> ${filename%.*}.md"
  fi
done

# 转换 PDF
for f in $(find "$INBOX/papers" -type f -name "*.pdf" 2>/dev/null); do
  filename=$(basename "$f")
  output="${f%.*}.md"
  if [ ! -f "$output" ]; then
    markitdown "$f" -o "$output" 2>/dev/null
    log "  转换: $filename -> ${filename%.*}.md"
  fi
done

# 转换图片 OCR
for f in $(find "$INBOX/images" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) 2>/dev/null); do
  filename=$(basename "$f")
  output="${f%.*}.md"
  if [ ! -f "$output" ]; then
    markitdown "$f" -o "$output" 2>/dev/null
    log "  OCR: $filename -> ${filename%.*}.md"
  fi
done

# 转换音频
for f in $(find "$INBOX/audio" -type f \( -name "*.mp3" -o -name "*.wav" -o -name "*.m4a" \) 2>/dev/null); do
  filename=$(basename "$f")
  output="${f%.*}.md"
  if [ ! -f "$output" ]; then
    markitdown "$f" -o "$output" 2>/dev/null
    log "  转录: $filename -> ${filename%.*}.md"
  fi
done

echo ""

# Step 3: Graphify 建图谱
log "🔍 Step 3: 构建知识图谱"
cd "$BRAIN_OS"
if [ -d "$INBOX" ] && [ "$(find "$INBOX" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')" -gt 0 ]; then
  graphify ./00-INBOX --obsidian --obsidian-dir ./00-INBOX/ --update 2>&1 | while read line; do
    echo "  $line"
  done
  log "  图谱更新完成"
else
  warn "  INBOX 中没有 Markdown 文件"
fi
echo ""

# Step 4: 提示 Nightly Pipeline
log "📋 Step 4: Brain OS Nightly Pipeline"
info "Nightly Pipeline 会在设定的时间自动运行"
info "如需手动触发，请运行: bash scripts/init-nightly-digest.sh"
echo ""

# 总结
echo "════════════════════════════════════════════════════════"
log "✅ 每日处理完成！"
echo ""
echo "📁 文件位置: $INBOX/"
echo "🔗 图谱位置: $INBOX/graphify-out/"
echo "📊 图谱报告: $INBOX/graphify-out/GRAPH_REPORT.md"
echo "🌐 交互图谱: $INBOX/graphify-out/graph.html"
echo ""
