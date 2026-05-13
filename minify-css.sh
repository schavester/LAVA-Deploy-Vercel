#!/usr/bin/env bash
set -euo pipefail

echo "=== Minifying CSS ==="
if ! command -v cleancss >/dev/null; then
  npm install -g clean-css-cli
fi

for css in $(find . -name "*.css" -type f | sort); do
  echo "Processing $css"
  cleancss "$css" -o "${css}.min.css"
  mv "${css}.min.css" "${css}.tmp"
  mv "${css}.tmp" "$css"
done

echo "=== Minifying JS ==="
if ! command -v terser >/dev/null; then
  npm install -g terser
fi

for js in $(find . -name "*.js" -type f | sort); do
  echo "Processing $js"
  terser "$js" --compress --mangle -o "${js}.min.js"
  mv "${js}.min.js" "${js}.tmp"
  mv "${js}.tmp" "$js"
done

echo "✅ Minification complete!"