#!/bin/bash
# 找到第一个 .yaml 文件
file=$(ls *.yaml | head -n 1)

# 如果文件存在
if [[ -n $file ]]; then
    # 复制文件为 config.yaml
    cp "$file" config.yaml
    echo "已将 $file 复制为 config.yaml"
else
    echo "没有找到 .yaml 文件"
fi
