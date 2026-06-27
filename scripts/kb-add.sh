#!/bin/bash
# kb-add — 团队知识入库脚本（绕过 Claude 判断，直接执行）
#
# Usage:
#   kb-add file <文件路径> [分类]        # 文件入库（自动 markitdown）
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
        {
            echo "---"
            echo "title: \"${FILENAME%.*}\""
            echo "type: $TYPE"
            echo "author: \"$(whoami)\""
            echo "date: $DATE"
            echo "tags: []"
            echo "source_file: _originals/$(basename "$ORIG_FILE")"
            echo "---"
            echo ""
            echo "$BODY"
        } > "$OUT_FILE"

        echo "✓ 已入库：$CATEGORY/$DATE-$SLUG.md"
        echo "  原文件：_originals/$(basename "$ORIG_FILE")"
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
            echo "tags: []"
            echo "---"
            echo ""
            echo "$CONTENT"
        } > "$OUT_FILE"

        echo "✓ 已入库：$CATEGORY/$DATE-$SLUG.md"
        ;;

    *)
        echo "Usage: kb-add file <文件路径> [分类]"
        echo "       kb-add text <分类> \"<标题>\" \"<内容>\""
        exit 1
        ;;
esac
