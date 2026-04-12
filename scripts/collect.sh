#!/bin/bash
# Knowledge Collector - 自动路由收集脚本
# 使用方式: ./collect.sh file1.docx "https://..." paper.pdf screenshot.png

# 配置
INBOX="/Users/songstephen/my-brain/00-INBOX"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 创建目录
mkdir -p "$INBOX"/{web,office,wechat,papers,images,audio,projects}

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
  echo -e "${GREEN}[collect]${NC} $1"
}

error() {
  echo -e "${RED}[error]${NC} $1"
}

# 添加 frontmatter
add_frontmatter() {
  local file="$1"
  local source="$2"
  local ext="${source##*.}"

  # 根据扩展名设置标签
  case "$ext" in
    doc|docx) tag="word" ;;
    ppt|pptx) tag="powerpoint" ;;
    pdf) tag="pdf" ;;
    mp3|wav|m4a|ogg) tag="audio" ;;
    mp4|mov|mkv|webm) tag="video" ;;
    jpg|jpeg|png|gif|webp) tag="image" ;;
    md) tag="markdown" ;;
    *) tag="document" ;;
  esac

  # 在文件开头插入 frontmatter
  local temp=$(mktemp)
  cat > "$temp" << EOF
---
created: $(date +%Y-%m-%d)
source: $source
type: $tag
tags: [收集]
---

EOF
  cat "$file" >> "$temp"
  mv "$temp" "$file"
}

# 处理文件
process_file() {
  local input="$1"
  local filename=$(basename "$input")
  local ext="${filename##*.}"
  local ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

  # 确定目标目录
  case "$ext_lower" in
    doc|docx)
      target_dir="$INBOX/office"
      ;;
    ppt|pptx)
      target_dir="$INBOX/office"
      ;;
    pdf)
      target_dir="$INBOX/papers"
      ;;
    mp3|wav|m4a|ogg)
      target_dir="$INBOX/audio"
      ;;
    mp4|mov|mkv|webm|m4v|avi)
      target_dir="$INBOX/audio"
      ;;
    jpg|jpeg|png|gif|webp|bmp)
      target_dir="$INBOX/images"
      ;;
    md|txt)
      target_dir="$INBOX/web"
      ;;
    py|js|ts|go|rs|java|cpp|c|h)
      target_dir="$INBOX/projects"
      ;;
    *)
      target_dir="$INBOX/web"
      ;;
  esac

  # 生成输出文件名
  local output="$target_dir/${TIMESTAMP}_${filename}.md"

  log "转换: $filename -> $target_dir/"
  markitdown "$input" -o "$output" 2>/dev/null

  if [ $? -eq 0 ] && [ -f "$output" ]; then
    add_frontmatter "$output" "$filename"
    log "已保存: $output"
  else
    error "转换失败: $input"
  fi
}

# 处理 URL
process_url() {
  local url="$1"
  local domain=$(echo "$url" | sed -E 's|.*://([^/]+).*|\1|')

  log "处理 URL: $url"

  # 判断域名类型
  if [[ "$url" == *"mp.weixin.qq.com"* ]]; then
    target_dir="$INBOX/wechat"
  elif [[ "$url" == *"youtube.com"* ]] || [[ "$url" == *"youtu.be"* ]]; then
    target_dir="$INBOX/audio"
  elif [[ "$url" == *"github.com"* ]] && [[ "$url" == *"/blob/"* ]]; then
    target_dir="$INBOX/projects"
  else
    target_dir="$INBOX/web"
  fi

  # 使用 markitdown 获取 URL 内容
  local filename=$(echo "$url" | sed -E 's|.*/([^/]+).*|\1|' | sed 's/\?.*//')
  [ -z "$filename" ] && filename="web_page"
  local output="$target_dir/${TIMESTAMP}_${filename}.md"

  markitdown "$url" -o "$output" 2>/dev/null

  if [ $? -eq 0 ] && [ -f "$output" ]; then
    add_frontmatter "$output" "$url"
    log "已保存: $output"
  else
    error "获取失败: $url"
  fi
}

# 处理微信公众号文章（需要 wexin-read-mcp）
process_wechat() {
  local url="$1"

  log "处理微信公众号文章: $url"
  target_dir="$INBOX/wechat"

  # 临时文件
  local temp_file="/tmp/wechat_${TIMESTAMP}.txt"
  local output="$target_dir/${TIMESTAMP}_wechat.md"

  # 使用 MCP 或其他方式获取微信文章
  # 这里需要配合 anything-to-notebooklm 的 wexin-read-mcp
  # 简化处理：直接用 markitdown 尝试
  markitdown "$url" -o "$output" 2>/dev/null

  if [ $? -eq 0 ] && [ -f "$output" ]; then
    add_frontmatter "$output" "$url"
    log "已保存: $output"
  else
    error "获取微信公众号失败，请尝试手动复制内容"
  fi
}

# 显示帮助
show_help() {
  echo "Knowledge Collector - 自动路由收集脚本"
  echo ""
  echo "使用方法:"
  echo "  ./collect.sh <file> [file2] [file3] ..."
  echo "  ./collect.sh <url> [url2] ..."
  echo "  ./collect.sh mixed.docx \"https://...\" image.png"
  echo ""
  echo "支持的格式:"
  echo "  Office:  .doc, .docx, .ppt, .pptx  -> office/"
  echo "  文档:    .pdf                       -> papers/"
  echo "  图片:    .jpg, .png, .gif ...       -> images/"
  echo "  音频:    .mp3, .wav, .mp4 ...       -> audio/"
  echo "  代码:    .py, .js, .go ...         -> projects/"
  echo "  网页:    .md, .txt, URL            -> web/"
  echo "  公众号:   mp.weixin.qq.com          -> wechat/"
  echo ""
  echo "示例:"
  echo "  ./collect.sh article.docx"
  echo "  ./collect.sh \"https://example.com/article\""
  echo "  ./collect.sh paper.pdf screenshot.png \"https://...\""
}

# 主逻辑
main() {
  if [ $# -eq 0 ]; then
    show_help
    exit 0
  fi

  log "开始收集... (${#} 个项目)"

  for item in "$@"; do
    if [[ "$item" == http* ]]; then
      process_url "$item"
    elif [[ -f "$item" ]]; then
      process_file "$item"
    elif [[ "$item" == "help" ]] || [[ "$item" == "--help" ]] || [[ "$item" == "-h" ]]; then
      show_help
    else
      error "无法识别: $item (不是文件也不是 URL)"
    fi
    TIMESTAMP=$((TIMESTAMP + 1))
  done

  echo ""
  log "收集完成！"
  echo ""
  echo "文件位置:"
  echo "  $INBOX/office/   - Word/PPT"
  echo "  $INBOX/papers/   - PDF"
  echo "  $INBOX/web/      - 网页/其他"
  echo "  $INBOX/images/   - 图片"
  echo "  $INBOX/audio/    - 音频/视频"
  echo "  $INBOX/projects/ - 代码项目"
  echo "  $INBOX/wechat/   - 公众号"
  echo ""
  echo "下一步: graphify ./00-INBOX --obsidian --obsidian-dir ./00-INBOX/ --update"
}

main "$@"
