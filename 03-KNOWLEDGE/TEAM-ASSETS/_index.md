# 团队知识资产索引

所有通过飞书桥接录入的团队知识资产（业务知识 / 数据 / PPT / 文档）。

## 录入方式

通过飞书私聊 bot 小o：
- 发文件（PPT/PDF/Word/Excel）→ 自动 markitdown 转 markdown 入库
- 发文字 → 整理为业务知识笔记入库
- 命令式：`知识入库 <分类> <标题>`（可选，不发也可自动判定分类）

## 分类

| 分类 | 目录 | 说明 |
|------|------|------|
| 业务知识 | `业务知识/` | 产品/客户/行业/市场分析 |
| 数据 | `数据/` | 数据源/指标/报表（Excel 等转 markdown） |
| PPT | `PPT/` | 演示文件（PPT 转文字版） |
| 文档 | `文档/` | 白皮书/案例/规范文档 |

## 元数据格式

每条记录的 markdown 头部：

```yaml
---
title: <标题>
type: ppt | pdf | word | excel | text
author: <员工姓名>
date: YYYY-MM-DD
project: <可选>
tags: [<标签>]
source_file: _originals/<原文件名>
---
```
