#!/bin/bash
# kb-worklog — 工作记录入库脚本（必须含时长）
#
# Usage:
#   kb-worklog "<员工姓名>" "<项目>" "<任务>" "<时长>" ["<产出描述>"]
#
# 时长格式：X小时 / X分钟 / Xh / Xmin（脚本只校验非空，由 Claude 负责语义判断）
#
# 缺参数时退出码：
#   2 = 缺员工
#   3 = 缺时长（关键场景：必须追问用户）

set -e

VAULT="/Users/oao/my-brain"
BASE="$VAULT/01-PERSONAL-OPS/06-TIMESHEETS/employees"
DATE=$(date +%Y-%m-%d)

EMPLOYEE="$1"
PROJECT="$2"
TASK="$3"
DURATION="$4"
OUTPUT="${5:-}"

# 校验必填项
if [[ -z "$EMPLOYEE" ]]; then
    echo "❌ 缺员工姓名" >&2
    exit 2
fi
if [[ -z "$DURATION" ]]; then
    echo "❌ 缺工作时长（必须追问用户）" >&2
    exit 3
fi

# 确保 employee 目录存在
mkdir -p "$BASE/$EMPLOYEE"
FILE="$BASE/$EMPLOYEE/$DATE.md"

# 如果今天还没文件，初始化
if [[ ! -f "$FILE" ]]; then
    {
        echo "---"
        echo "title: 工时记录 - $EMPLOYEE - $DATE"
        echo "date: $DATE"
        echo "employee: $EMPLOYEE"
        echo "---"
        echo ""
        echo "# 工时记录 - $DATE"
        echo ""
    } > "$FILE"
fi

# 追加条目
if [[ -n "$OUTPUT" ]]; then
    echo "- $PROJECT | $TASK | $DURATION | $OUTPUT" >> "$FILE"
else
    echo "- $PROJECT | $TASK | $DURATION |" >> "$FILE"
fi

echo "✓ 已记录：$EMPLOYEE/$DATE.md"
echo "  条目：$PROJECT | $TASK | $DURATION${OUTPUT:+ | $OUTPUT}"
