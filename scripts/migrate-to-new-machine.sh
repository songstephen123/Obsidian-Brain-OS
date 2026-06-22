#!/usr/bin/env bash
# =============================================================================
# Brain OS — One-shot migration to a new machine
# =============================================================================
# Usage:
#   1. On the OLD machine, run:
#        scp ~/my-brain/scripts/migrate-to-new-machine.sh NEW_USER@NEW_PC:/tmp/
#
#   2. On the NEW machine, run:
#        bash /tmp/migrate-to-new-machine.sh OLD_HOSTNAME
#
#   OLD_HOSTNAME = hostname or IP of your old Mac (must be reachable via ssh/scp)
#
# If you've already copied config.env and ~/.claude/scripts/ manually, set:
#   SKIP_SCP=1 bash /tmp/migrate-to-new-machine.sh
# =============================================================================

set -euo pipefail

OLD_HOST="${1:-}"

# ── Colors ──────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'

step()  { echo -e "\n${BOLD}${BLUE}━━━ $1 ━━━${NC}"; }
ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC}  $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; }

# ── Safety checks ───────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script is for macOS only."; exit 1
fi

NEW_USER=$(whoami)
NEW_HOME="/Users/$NEW_USER"
BRAIN="$NEW_HOME/my-brain"
SCRIPTS_DIR="$NEW_HOME/.claude/scripts"

echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║   Brain OS  —  New Machine Migration        ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Target user:  ${GREEN}$NEW_USER${NC}"
echo -e "  Brain path:   ${GREEN}$BRAIN${NC}"
echo ""

# ── Step 1: Pull non-git files from old machine ─────────────────
if [[ "${SKIP_SCP:-0}" = "1" ]]; then
  warn "SKIP_SCP=1 — skipping remote copy. Make sure you've manually copied:"
  warn "  • ~/.claude/scripts/  →  $SCRIPTS_DIR/"
  warn "  • ~/my-brain/scripts/config.env  →  /tmp/config.env"
elif [[ -z "$OLD_HOST" ]]; then
  fail "Missing OLD_HOST argument."
  echo "  Usage: bash $0 OLD_HOSTNAME"
  echo "  Or set SKIP_SCP=1 if files are already in place."
  exit 1
else
  step "Step 1: Pulling files from old machine ($OLD_HOST)"

  if scp -r "$OLD_HOST:.claude/scripts/" "$SCRIPTS_DIR/" 2>/dev/null; then
    ok "Copied ~/.claude/scripts/"
  else
    fail "Failed to copy ~/.claude/scripts/ from $OLD_HOST"
    warn "Continuing — you'll need these scripts for cron to work"
  fi

  if scp "$OLD_HOST:my-brain/scripts/config.env" "/tmp/config.env" 2>/dev/null; then
    ok "Copied config.env"
  else
    warn "Failed to copy config.env — you'll need to create it manually"
  fi
fi

# ── Step 2: Install base toolchain ──────────────────────────────
step "Step 2: Checking base toolchain"

# Homebrew
if ! command -v brew &>/dev/null; then
  warn "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || \
    eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
  ok "Homebrew installed"
else
  ok "Homebrew: $(brew --version | head -1)"
fi

# pipx
if ! command -v pipx &>/dev/null; then
  brew install pipx
  pipx ensurepath
  export PATH="$NEW_HOME/.local/bin:$PATH"
  ok "pipx installed"
else
  ok "pipx: $(pipx --version)"
fi

# Node / Claude Code
if ! command -v claude &>/dev/null && ! command -v npm &>/dev/null; then
  warn "Installing Node.js..."
  brew install node
fi

if ! command -v claude &>/dev/null; then
  warn "Installing Claude Code CLI..."
  npm install -g @anthropic-ai/claude-code
  ok "Claude Code installed"
else
  ok "Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
fi

# jq (needed by some scripts)
brew install jq 2>/dev/null && ok "jq installed" || ok "jq already present"

# ── Step 3: Clone Brain OS repo ─────────────────────────────────
step "Step 3: Cloning Brain OS repository"

if [[ -d "$BRAIN/.git" ]]; then
  ok "Brain OS already cloned at $BRAIN"
  cd "$BRAIN" && git pull --ff-only 2>/dev/null || warn "Could not git pull (dirty tree?)"
else
  git clone https://github.com/FairladyZ625/Obsidian-Brain-OS.git "$BRAIN"
  ok "Cloned to $BRAIN"
fi

# Place config.env
if [[ -f "/tmp/config.env" ]]; then
  mv /tmp/config.env "$BRAIN/scripts/config.env"
  ok "config.env placed"
else
  warn "No /tmp/config.env — copy it manually to $BRAIN/scripts/config.env"
fi

# ── Step 4: Install Python CLI tools ────────────────────────────
step "Step 4: Installing CLI tools (graphify, conversation-mining, markitdown)"

export PATH="$NEW_HOME/.local/bin:$PATH"

if ! command -v graphify &>/dev/null; then
  pipx install graphifyy && ok "graphify installed" || warn "graphify install failed"
else
  ok "graphify: $(graphify --version 2>/dev/null || echo 'installed')"
fi

if ! command -v markitdown &>/dev/null; then
  pipx install markitdown && ok "markitdown installed" || warn "markitdown install failed"
else
  ok "markitdown: installed"
fi

if ! command -v conversation-mining &>/dev/null; then
  if [[ -d "$BRAIN/tools/conversation-mining" ]]; then
    cd "$BRAIN/tools/conversation-mining"
    pipx install . && ok "conversation-mining installed" || warn "conversation-mining install failed"
  fi
else
  ok "conversation-mining: installed"
fi

# ── Step 5: Replace all hardcoded paths ─────────────────────────
step "Step 5: Replacing hardcoded paths (/Users/songstephen → $NEW_HOME)"

cd "$BRAIN"
find scripts prompts -type f \( -name "*.sh" -o -name "*.md" -o -name "*.py" -o -name "*.env" \) \
  -exec sed -i '' "s|/Users/songstephen|$NEW_HOME|g" {} +
ok "Replaced paths in ~/my-brain/"

if [[ -d "$SCRIPTS_DIR" ]]; then
  cd "$SCRIPTS_DIR"
  find . -type f \( -name "*.sh" -o -name "*.txt" \) \
    -exec sed -i '' "s|/Users/songstephen|$NEW_HOME|g" {} +
  ok "Replaced paths in ~/.claude/scripts/"
else
  warn "~/.claude/scripts/ not found — skipping path replacement there"
fi

# Fix Claude Code binary path (may differ per nvm/node version)
WHICH_CLAUDE=$(which claude 2>/dev/null || echo "claude")
if [[ -f "$SCRIPTS_DIR/brain-os-cron-wrapper.sh" ]]; then
  sed -i '' "s|CLAUDE_BIN=.*|CLAUDE_BIN=\"$WHICH_CLAUDE\"|" \
    "$SCRIPTS_DIR/brain-os-cron-wrapper.sh"
  ok "CLAUDE_BIN → $WHICH_CLAUDE"
fi

# ── Step 6: Verify no stale paths remain ────────────────────────
step "Step 6: Verifying no stale paths remain"

STALE=$(grep -r '/Users/songstephen' "$BRAIN/scripts" "$BRAIN/prompts" "$SCRIPTS_DIR" 2>/dev/null || true)
if [[ -z "$STALE" ]]; then
  ok "No stale paths — clean!"
else
  warn "Some stale paths remain (probably in comments or non-critical):"
  echo "$STALE" | head -5
fi

# ── Step 7: Install cron jobs ───────────────────────────────────
step "Step 7: Installing cron jobs"

if [[ -f "$SCRIPTS_DIR/install-brain-os-cron.sh" ]]; then
  bash "$SCRIPTS_DIR/install-brain-os-cron.sh"
  ok "Personal Ops cron installed"
else
  warn "install-brain-os-cron.sh not found"
fi

if [[ -f "$SCRIPTS_DIR/install-nightly-pipeline.sh" ]]; then
  bash "$SCRIPTS_DIR/install-nightly-pipeline.sh"
  ok "Nightly Pipeline cron installed"
else
  warn "install-nightly-pipeline.sh not found"
fi

echo ""
CRON_COUNT=$(crontab -l 2>/dev/null | grep -c 'brain-os' || echo "0")
ok "crontab entries: $CRON_COUNT (expect 12)"

# ── Step 8: Verification ────────────────────────────────────────
step "Step 8: Verification"

PASS=0; FAIL=0

check() {
  local desc="$1"; shift
  if "$@" &>/dev/null; then
    ok "$desc"; ((PASS++)) || true
  else
    fail "$desc"; ((FAIL++)) || true
  fi
}

check "git repo"         git -C "$BRAIN" status &>/dev/null
check "graphify"         command -v graphify
check "conversation-mining" command -v conversation-mining
check "markitdown"       command -v markitdown
check "config.env"       test -f "$BRAIN/scripts/config.env"
check "cron wrapper"     test -f "$SCRIPTS_DIR/brain-os-cron-wrapper.sh"
check "send-notification" test -f "$SCRIPTS_DIR/send-notification.sh"

# Test run the simplest cron task
echo ""
step "Dry-run: testing cron wrapper"
if bash "$SCRIPTS_DIR/brain-os-cron-wrapper.sh" "test" \
     "$BRAIN/prompts/cron/personal-ops-morning-brief.md" 2>&1 | tail -5; then
  ok "Cron wrapper test passed"
else
  warn "Cron wrapper test had issues (check logs in $BRAIN/.cron-logs/)"
fi

# ── Summary ─────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║   Migration Complete                         ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}$PASS passed${NC}  ${RED}$FAIL failed${NC}"
echo ""
echo -e "  ${BOLD}Next steps:${NC}"
echo "  1. Install Obsidian:  https://obsidian.md/download"
echo "  2. Open vault:         $BRAIN"
echo "  3. Install community plugins (calendar, dataview, make-md, etc.)"
echo "  4. Check cron:         crontab -l | grep brain-os"
echo "  5. Wait for 07:00 morning brief, or manually test a task"
echo "  6. Review config:      vim $BRAIN/scripts/config.env"
echo ""
