#!/usr/bin/env bash

DIR="$1"

if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then
  exit 1
fi

cd "$DIR" || exit 1

echo "FILES: $(find . -mindepth 1 -type f | wc -l | tr -d ' ')"
echo "DIRS: $(find . -mindepth 1 -type d | wc -l | tr -d ' ')"

echo "LARGEST:"
find . -type f -exec stat -f "%z %N" {} + | sed 's|^\./||' | sort -nr | head -n 3

echo "EXECUTABLE:"
find . -type f -perm -100 | sed 's|^\./||' | sort

echo "EXTENSIONS:"
find . -type f -name "*.*" | awk -F. 'NF>1 {print $NF}' | sort | uniq -c | sort -nr -k1,1 -k2,2 | head -n 5 | awk '{print $1 " ." $2}'