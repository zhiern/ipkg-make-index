#!/bin/bash
# 用于为每个架构目录自动生成 index.json

set -e
root_dir="${1:-.}"

for arch_dir in "$root_dir"/*/; do
    [ -d "$arch_dir" ] || continue

    arch_name=$(basename "$arch_dir")
    index_file="$arch_dir/index.json"

    echo "📦 正在生成架构 [$arch_name] 的 index.json..."

    echo "{" > "$index_file"
    echo "  \"architecture\": \"$arch_name\"," >> "$index_file"
    echo "  \"packages\": {" >> "$index_file"

    first=1
    for ipk in "$arch_dir"/*.ipk; do
        [ -f "$ipk" ] || continue

        filename=$(basename "$ipk")
        name="${filename%%_*}"
        version="${filename#*_}"
        version="${version%%_*}"

        if [ $first -eq 0 ]; then
            echo "," >> "$index_file"
        fi
        first=0

        echo -n "    \"$name\": \"$version\"" >> "$index_file"
    done

    echo "" >> "$index_file"
    echo "  }" >> "$index_file"
    echo "}" >> "$index_file"

    echo "✅ $arch_name/index.json 生成完毕 ✅"
done
