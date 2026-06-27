---
name: timesheet-monthly-summary
schedule: "0 9 1 * *"
agent: main
timeout: 600
enabled: true
description: 每月1日09:00 — 汇总上月员工工时报告，写入 Obsidian
delivery_mode: announce
---

# 月度工时汇总

每月1日执行，汇总上月所有员工的工时记录。

## 执行步骤

1. 读取 `/Users/oao/my-brain/01-PERSONAL-OPS/06-TIMESHEETS/employees/` 下的员工映射文件
2. 对每个员工，读取其上月的日报文件
3. 按员工汇总：

   | 员工 | 总工时 | 项目分布 | 出勤天数 |
   |------|--------|---------|---------|

4. 写入汇总报告到：
   `/Users/oao/my-brain/01-PERSONAL-OPS/06-TIMESHEETS/monthly-summary/<YYYY-MM>.md`
