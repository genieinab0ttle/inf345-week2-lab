#!/usr/bin/env bash

set -euo pipefail

dir="${1:?usage: report.sh <directory>}"

echo "FILES: $(find "$dir" -type f | wc -l)"
echo "DIRS: $(find "$dir" -mindepth 1 -type d | wc -l)"

echo "LARGEST:"
find "$dir" -type f -exec stat -f "%z %N" {} \; | sort -nr | head -3 | sed "s|$dir/||"

echo "EXECUTABLE:"
find "$dir" -type f -perm -u+x | sed "s|$dir/||" | sort

echo "EXTENSIONS:"
find "$dir" -type f | sed 's|.*/||' | grep '\.' | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -5 | awk '{print $1 " ." $2}'