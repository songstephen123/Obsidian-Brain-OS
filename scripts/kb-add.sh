#!/bin/bash
# kb-add — 团队知识入库脚本（绕过 Claude 判断，直接执行）
#
# Usage:
#   kb-add file <文件路径> [分类]        # 文件入库（自动 markitdown）
#   kb-add url  <URL> [分类]             # URL 入库（markitdown 抓取 + 转换）
#   kb-add text <分类> "<标题>" "<内容>"  # 文字入库
#
# 分类可选: 业务知识 / 数据 / PPT / 文档（默认按文件类型或"业务知识"）

set -e

VAULT="/Users/oao/my-brain"
BASE="$VAULT/03-KNOWLEDGE/TEAM-ASSETS"
ORIG_DIR="$BASE/_originals"
DATE=$(date +%Y-%m-%d)

mkdir -p "$ORIG_DIR"

# 分类自动判定（按扩展名）
infer_category() {
    local ext="${1##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
    case "$ext" in
        ppt|pptx|key) echo "PPT" ;;
        xls|xlsx|csv|numbers) echo "数据" ;;
        doc|docx|pdf|pages|rtf|txt|md) echo "文档" ;;
        *) echo "业务知识" ;;
    esac
}

# type 字段（按扩展名）
infer_type() {
    local ext="${1##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
    case "$ext" in
        ppt|pptx|key) echo "ppt" ;;
        xls|xlsx|csv|numbers) echo "excel" ;;
        doc|docx|pages|rtf) echo "word" ;;
        pdf) echo "pdf" ;;
        png|jpg|jpeg|gif|webp) echo "image" ;;
        *) echo "text" ;;
    esac
}

# 生成 slug（标题或文件名转 URL-safe）
make_slug() {
    echo "$1" | tr -d '[:space:]' | tr -d '/<>:"\\|?*' | head -c 40
}

case "$1" in
    file)
        FILE_PATH="$2"
        CATEGORY="${3:-}"
        if [[ ! -f "$FILE_PATH" ]]; then
            echo "❌ 文件不存在: $FILE_PATH" >&2
            exit 1
        fi
        FILENAME=$(basename "$FILE_PATH")
        EXT="${FILENAME##*.}"
        [[ -z "$CATEGORY" ]] && CATEGORY=$(infer_category "$FILENAME")
        TYPE=$(infer_type "$FILENAME")
        SLUG=$(make_slug "${FILENAME%.*}")
        OUT_FILE="$BASE/$CATEGORY/$DATE-$SLUG.md"
        ORIG_FILE="$ORIG_DIR/$DATE-$FILENAME"

        mkdir -p "$BASE/$CATEGORY"
        cp "$FILE_PATH" "$ORIG_FILE"

        # 先生成 body（-p 启用第三方插件，未来装插件时自动生效）
        BODY=$(markitdown -p "$FILE_PATH" 2>/dev/null || echo "（markitdown 转换失败，请手动检查原文件）")

        # 写入 markdown（frontmatter + body）
        # source/topic/process 留 auto 占位，由 Claude 在调用后用 Edit 回填
        {
            echo "---"
            echo "title: \"${FILENAME%.*}\""
            echo "type: $TYPE"
            echo "author: \"$(whoami)\""
            echo "date: $DATE"
            echo "source: auto              # internal | external | auto（待 Claude 回填）"
            echo "topic: []                 # 待 Claude 回填，如 [客户A, 销售复盘]"
            echo "process: auto             # yes | no | auto（是否进提炼管道，待 Claude 回填）"
            echo "tags: []"
            echo "source_file: _originals/$(basename "$ORIG_FILE")"
            echo "---"
            echo ""
            echo "$BODY"
        } > "$OUT_FILE"

        echo "✓ 已入库：$CATEGORY/$DATE-$SLUG.md"
        echo "  原文件：_originals/$(basename "$ORIG_FILE")"
        echo "  ⚠ frontmatter 的 source/topic/process 字段是 auto 占位"
        echo "    Claude 调用时应继续用 Edit 工具回填（读内容 → 推断标签 → 改 frontmatter）"
        ;;

    text)
        CATEGORY="$2"
        TITLE="$3"
        CONTENT="$4"
        [[ -z "$CATEGORY" ]] && CATEGORY="业务知识"
        [[ -z "$TITLE" ]] && { echo "❌ 缺少标题" >&2; exit 1; }
        [[ -z "$CONTENT" ]] && { echo "❌ 缺少内容" >&2; exit 1; }

        SLUG=$(make_slug "$TITLE")
        OUT_FILE="$BASE/$CATEGORY/$DATE-$SLUG.md"
        mkdir -p "$BASE/$CATEGORY"

        {
            echo "---"
            echo "title: \"$TITLE\""
            echo "type: text"
            echo "author: \"$(whoami)\""
            echo "date: $DATE"
            echo "source: auto              # internal | external | auto（待 Claude 回填）"
            echo "topic: []                 # 待 Claude 回填"
            echo "process: auto             # yes | no | auto（待 Claude 回填）"
            echo "tags: []"
            echo "---"
            echo ""
            echo "$CONTENT"
        } > "$OUT_FILE"

        echo "✓ 已入库：$CATEGORY/$DATE-$SLUG.md"
        echo "  ⚠ frontmatter 的 source/topic/process 字段是 auto 占位，Claude 应继续用 Edit 回填"
        ;;

    url)
        URL="$2"
        CATEGORY="${3:-文档}"
        if [[ -z "$URL" ]]; then
            echo "❌ 缺少 URL" >&2
            exit 1
        fi
        if [[ ! "$URL" =~ ^https?:// ]]; then
            echo "❌ URL 必须以 http:// 或 https:// 开头" >&2
            exit 1
        fi

        # 用 markitdown 抓取并转换
        BODY=$(markitdown "$URL" 2>/dev/null)
        if [[ -z "$BODY" || "$BODY" == *"ERROR"* ]]; then
            echo "❌ markitdown 抓取失败：$URL" >&2
            exit 1
        fi

        # 从 URL 推断标题（取最后一截 path，去掉 .html / 查询参数）
        SLUG=$(echo "$URL" | sed -E 's|^[^:]+://||' | sed -E 's|/+$||' | sed -E 's|.*/||' | sed -E 's|\.[a-z]+$||' | sed -E 's|[^a-zA-Z0-9_-]+|_|g' | head -c 60)
        [[ -z "$SLUG" ]] && SLUG="web-page"
        TITLE="$SLUG"

        # URL 默认进"业务知识"（外部文章通常是业务/行业内容）
        # 用户可传第 3 个参数指定分类
        OUT_FILE="$BASE/$CATEGORY/$DATE-$SLUG.md"
        mkdir -p "$BASE/$CATEGORY"

        {
            echo "---"
            echo "title: \"$TITLE\""
            echo "type: web"
            echo "source_url: $URL"
            echo "author: \"$(whoami)\""
            echo "date: $DATE"
            echo "source: external          # URL 入库默认 external"
            echo "topic: []                 # 待 Claude 回填"
            echo "process: auto             # yes | no | auto（待 Claude 回填）"
            echo "tags: []"
            echo "---"
            echo ""
            echo "$BODY"
        } > "$OUT_FILE"

        echo "✓ 已入库：$CATEGORY/$DATE-$SLUG.md"
        echo "  来源：$URL"
        echo "  ⚠ frontmatter 的 topic/process 字段是占位，Claude 应继续用 Edit 回填"
        ;;

    *)
        echo "Usage: kb-add file <文件路径> [分类]"
        echo "       kb-add url <URL> [分类]"
        echo "       kb-add text <分类> \"<标题>\" \"<内容>\""
        exit 1
        ;;
esac
