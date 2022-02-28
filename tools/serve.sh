#!/usr/bin/env bash

#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# A simple script to launch a web server in this folder and start watchman.
#

set -euo pipefail

cd docs/
python3 -m http.server "${PORT:-8000}" &
http_server_pid="$!"
trap 'kill "$http_server_pid"' EXIT

cd -

if [ "$(uname)" = "Darwin" ]; then
  open "http://127.0.0.1:8000"
else
  xdg-open "http://127.0.0.1:8000"
fi

watchman-make -p 'src/*' 'public/*' '*.html5' 'Makefile' -r 'make'
