#!/bin/bash
# 壁纸目录
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# 随机选择一张图片（支持常见格式）
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf -n1)

if [ -n "$WALLPAPER" ]; then
    # 使用随机过渡效果，持续时间 3 秒
    swww img "$WALLPAPER" --transition-type random --transition-duration 3
else
    echo "未在 $WALLPAPER_DIR 中找到图片"
fi
