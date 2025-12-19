#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -d "$SCRIPT_DIR/spiel" ]]; then
  ROOT="$SCRIPT_DIR/spiel"
elif [[ -d "./berichte" ]]; then
  ROOT="$(pwd)"
else
  echo "❌ Spielordner nicht gefunden."
  exit 2
fi

STAT="$ROOT/statistik.txt"
echo "🔎 LÖSEN / PRÜFEN (Lektion 4)"
echo

ok=1
if [[ -f "$STAT" ]]; then
  echo "✅ 1) statistik.txt existiert."
else
  echo "❌ 1) statistik.txt fehlt. Tipp: ls > statistik.txt"
  ok=0
fi

files_in_berichte=$(find "$ROOT/berichte" -type f 2>/dev/null | wc -l | tr -d ' ')
total_lines=$(wc -l "$ROOT/berichte/"*.txt 2>/dev/null | tail -n 1 | awk '{print $1}' | tr -d ' ')

if [[ -f "$STAT" ]]; then
  lines_in_stat=$(wc -l "$STAT" | awk '{print $1}' | tr -d ' ')
  [[ "$lines_in_stat" -ge 3 ]] && echo "✅ 2) Mindestens 3 Zeilen (gut für > und >>)." || { echo "❌ 2) Zu wenige Zeilen."; ok=0; }
  grep -q "$files_in_berichte" "$STAT" && echo "✅ 3) Anzahl Bericht-Dateien ($files_in_berichte) steht drin." || { echo "❌ 3) Anzahl Bericht-Dateien fehlt. Tipp: find berichte -type f | wc -l"; ok=0; }
  grep -q "$total_lines" "$STAT" && echo "✅ 4) Gesamtzeilen ($total_lines) steht drin." || { echo "❌ 4) Gesamtzeilen fehlen. Tipp: wc -l berichte/*.txt"; ok=0; }
fi

echo
if [[ $ok -eq 1 ]]; then
  echo "🏆 GEWONNEN!"
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 4 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-4-geschafft.txt"
  exit 0
else
  exit 1
fi
