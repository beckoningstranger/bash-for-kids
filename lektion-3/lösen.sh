#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -d "$SCRIPT_DIR/spiel" ]]; then
  ROOT="$SCRIPT_DIR/spiel"
elif [[ -d "./zimmer-jakob" && -d "./zimmer-sophia" ]]; then
  ROOT="$(pwd)"
else
  echo "❌ Spielordner nicht gefunden."
  exit 2
fi

hint_count=$(find "$ROOT" -type f -name "hinweis-*" 2>/dev/null | wc -l | tr -d ' ')
task1=$([[ "$hint_count" -ge 2 ]] && echo 1 || echo 0)

code_hits=$(grep -R -i "code" "$ROOT" 2>/dev/null | wc -l | tr -d ' ')
task2=$([[ "$code_hits" -ge 2 ]] && echo 1 || echo 0)

read -p "Gib den Lösungs-Code ein (z.B. DRACHE-42): " input
task3=$([[ "$input" == "DRACHE-42" ]] && echo 1 || echo 0)

echo "Checkliste:"
[[ $task1 -eq 1 ]] && echo "✅ 1) Hinweis-Dateien gefunden." || echo "❌ 1) Hinweis-Dateien fehlen. Tipp: find spiel -name "hinweis-*""
[[ $task2 -eq 1 ]] && echo "✅ 2) CODE-Zeilen gefunden." || echo "❌ 2) CODE-Zeilen fehlen. Tipp: grep -R CODE spiel"
[[ $task3 -eq 1 ]] && echo "✅ 3) Code stimmt." || echo "❌ 3) Code ist falsch."

if [[ $task1 -eq 1 && $task2 -eq 1 && $task3 -eq 1 ]]; then
  echo "🏆 GEWONNEN!"
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 3 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-3-geschafft.txt"
  exit 0
else
  exit 1
fi
