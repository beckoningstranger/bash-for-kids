#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT"/{zimmer-jakob/{boden,schreibtisch},zimmer-sophia/{boden,schreibtisch},keller,flur}

generate_file() {
  local path="$1"
  local word="$2"
  {
    for i in $(seq 1 100); do
      echo "$(head -c 80 /dev/urandom | tr -dc 'a-zA-Z ')"
    done
    echo "CODE ($word)"
  } > "$path"
}

generate_file "$ROOT/zimmer-jakob/boden/hinweis-rot.txt" "Von"
generate_file "$ROOT/keller/hinweis-blau.txt" "Hobbingen"
generate_file "$ROOT/flur/hinweis-gruen.txt" "zum Einsamen"
generate_file "$ROOT/zimmer-sophia/schreibtisch/hinweis-gelb.txt" "Berg"

echo "✅ Lektion 3 ist bereit."
