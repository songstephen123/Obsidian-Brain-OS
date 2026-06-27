# 员工工时映射

每个员工一个文件，文件名：`员工姓名.md`

内容格式：
```
lark_user_id: ou_xxxxx   # 飞书用户的 open_id
name: 张三               # 员工姓名
department: 设计部        # 可选
```

## 如何获取 Lark User ID

在飞书群/私聊给 bot 发一条消息，然后在 bridge 日志（`~/.lark-channel/profiles/claude/logs/`）中找到
`senderId` 字段。
