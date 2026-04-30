---
title: "Nexus4CC + Tailscale: 手机远程控制 Claude Code"
date: "2026-04-30"
source: conversation
transcript: "~/.claude/projects/-Users-songstephen/f0b7dc9c-6875-4f7b-bd24-4193efb4aa16.jsonl"
tags: [tooling, mobile, remote-access, claude-code]
type: pattern-candidate
---

# Nexus4CC + Tailscale: 手机远程控制 Claude Code

## 问题

Claude Code 只能在电脑终端运行，但时间碎片化（通勤、开会、离开工位），需要随时随地操控。

## 方案

**Nexus4CC** (librae8226/nexus4cc) — 自托管移动端 Claude Code 控制面板：
- WebSocket ↔ tmux 桥接，每个窗口一个终端会话
- xterm.js 移动优先终端，滑动切换窗口
- 文件浏览器、任务面板、项目/频道管理
- PWA 可安装到手机主屏

**Tailscale** — 安全访问层：
- WireGuard 端到端加密，零配置
- Mac Tailscale IP: `100.114.50.12`
- 手机访问 `http://100.114.50.12:59000`
- 无需公网 IP、无需端口映射

## 设置记录

```bash
# Nexus4CC
cd /tmp && git clone https://github.com/librae8226/nexus4cc.git
cd nexus4cc && npm install && npm run build:all
npm start  # 运行在 localhost:59000，密码 nexus123

# Tailscale
brew install --cask tailscale
tailscale ip -4  # 获取 VPN IP
```

## 已知问题

- 移动端 xterm.js 键盘输入可能不显示字符（实际已发送）
- 项目官方支持 Linux/WSL2，macOS 可能有兼容性差异

## 适用场景

- 通勤时用手机发指令写代码
- 开会时偷偷改 Bug
- 离开工位前启动长任务
- 多任务并行（多 tmux 窗口）
