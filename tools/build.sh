#!/usr/bin/env bash

#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# A simple script to build an HTML file using Pandoc
#

set -euo pipefail

usage() {
  echo 'usage: $0 <source.md> [<dest.html>]'
}

source="${1:-}"

if [ "${source}" = "" ]; then
  exit 1
fi

case "$source" in
  -h|--help)
    usage
    exit
    ;;
esac

dest="${2:-}"

if [ "$dest" = "" ]; then
  dest="$(basename "$src" .md).html"
fi

pandoc \
  --katex \
  --from markdown+tex_math_single_backslash \
  --filter pandoc-sidenote \
  --to html5+smart \
  --template=template \
  --css=theme.css \
  --css=skylighting-solarized-theme.css \
  --toc \
  --output "$dest" \
  "$source"
