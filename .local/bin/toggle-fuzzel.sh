#!/bin/bash
# 检查 fuzzel 是否正在运行
if pgrep -x "fuzzel" > /dev/null; then
    # 如果正在运行，则关闭它（发送 SIGTERM 优雅退出）
    pkill -x "fuzzel"
else
    # 如果没有运行，则启动它
    fuzzel &
fi
