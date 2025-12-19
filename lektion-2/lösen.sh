#!/usr/bin/env bash
set -u

# Robust: funktioniert, egal ob aus lektion-2 oder aus lektion-2/spiel gestartet
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -d "$SCRIPT_DIR/spiel" ]]; then
  ROOT="$SCRIPT_DIR/spiel"
elif [[ -d "./ablage" && -d "./zimmer-jakob" ]]; then
  ROOT="$(pwd)"
else
  echo "❌ Ich finde den Spielordner nicht."
  echo "Starte dieses Skript aus lektion-2 oder aus lektion-2/spiel."
  exit 2
fi

# Helpers
exists_file () { [[ -f "$1" ]]; }

# Check 1: jpg in ablage/bilder
jpg_elsewhere=0
while IFS= read -r -d '' f; do
  if [[ "$f" != "$ROOT/ablage/bilder/"* ]]; then
    jpg_elsewhere=$((jpg_elsewhere+1))
  fi
done < <(find "$ROOT" -type f -name "*.jpg" -print0 2>/dev/null)
task1=$([[ $jpg_elsewhere -eq 0 ]] && echo 1 || echo 0)

# Check 2: txt (excluding special) in ablage/texte
txt_bad=0
while IFS= read -r -d '' f; do
  base="$(basename "$f")"
  if [[ "$base" == "geheimcode.txt" || "$base" == "poster.txt" || "$base" == "todo.txt" ]]; then
    continue
  fi
  if [[ "$f" != "$ROOT/ablage/texte/"* ]]; then
    txt_bad=$((txt_bad+1))
  fi
done < <(find "$ROOT" -type f -name "*.txt" -print0 2>/dev/null)
task1b=$([[ $txt_bad -eq 0 ]] && echo 1 || echo 0)

# Task 2: specials on both desks
gc_j=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/geheimcode.txt" ]] && echo 1 || echo 0)
gc_s=$([[ -f "$ROOT/zimmer-sophia/schreibtisch/geheimcode.txt" ]] && echo 1 || echo 0)
po_j=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/poster.txt" ]] && echo 1 || echo 0)
po_s=$([[ -f "$ROOT/zimmer-sophia/schreibtisch/poster.txt" ]] && echo 1 || echo 0)
task2=$([[ $gc_j -eq 1 && $gc_s -eq 1 && $po_j -eq 1 && $po_s -eq 1 ]] && echo 1 || echo 0)

# Task 3: kaputt.tmp deleted
task3=$([[ ! -e "$ROOT/zimmer-jakob/schrank/kaputt.tmp" && ! -e "$ROOT/ablage/muell/kaputt.tmp" && ! -e "$ROOT/kaputt.tmp" ]] && echo 1 || echo 0)

# Task 4: todo exists on Jakob desk
task4=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/todo.txt" ]] && echo 1 || echo 0)

echo "🔎 LÖSEN / PRÜFEN (Lektion 2)"
echo "Spielordner: $ROOT"
echo
echo "Aufgaben-Checkliste:"

# Show all tasks with checkmarks
if [[ $task1 -eq 1 && $task1b -eq 1 ]]; then
  echo "✅ 1) Aufräumen: Bilder UND Texte sind richtig einsortiert."
else
  echo "❌ 1) Aufräumen noch nicht fertig."
  if [[ $task1 -eq 0 ]]; then
    echo "   - Es gibt noch .jpg Dateien außerhalb von ablage/bilder."
    echo "     Tipp: find spiel -name "*.jpg""
  fi
  if [[ $task1b -eq 0 ]]; then
    echo "   - Es gibt noch .txt Dateien außerhalb von ablage/texte (Ausnahmen: geheimcode/poster/todo)."
    echo "     Tipp: find spiel -name "*.txt""
  fi
fi

if [[ $task2 -eq 1 ]]; then
  echo "✅ 2) Doppelt: geheimcode.txt und poster.txt liegen auf BEIDEN Schreibtischen."
else
  echo "❌ 2) Doppelt noch nicht fertig."
  [[ $gc_j -eq 0 ]] && echo "   - geheimcode.txt fehlt auf Jakobs Schreibtisch."
  [[ $gc_s -eq 0 ]] && echo "   - geheimcode.txt fehlt auf Sophias Schreibtisch."
  [[ $po_j -eq 0 ]] && echo "   - poster.txt fehlt auf Jakobs Schreibtisch."
  [[ $po_s -eq 0 ]] && echo "   - poster.txt fehlt auf Sophias Schreibtisch."
  echo "   Tipp: Du brauchst cp (kopieren), nicht nur mv."
fi

if [[ $task3 -eq 1 ]]; then
  echo "✅ 3) Müll weg: kaputt.tmp ist wirklich gelöscht."
else
  echo "❌ 3) Müll weg noch nicht fertig."
  echo "   - kaputt.tmp ist noch irgendwo da."
  echo "     Tipp: rm spiel/zimmer-jakob/schrank/kaputt.tmp"
fi

if [[ $task4 -eq 1 ]]; then
  echo "✅ 4) Neu erstellt: todo.txt liegt auf Jakobs Schreibtisch."
else
  echo "❌ 4) Neu erstellt noch nicht fertig."
  echo "   - Erstelle die Datei mit: touch spiel/zimmer-jakob/schreibtisch/todo.txt"
fi

echo
echo "----------------------------------------"

if [[ $task1 -eq 1 && $task1b -eq 1 && $task2 -eq 1 && $task3 -eq 1 && $task4 -eq 1 ]]; then
  echo "🏆 GEWONNEN! Super gemacht!"
  echo

  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 2 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-2-geschafft.txt"

  # Lexikon aktualisieren
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 2)
Lies diese Datei mit: less ~/bash-lexikon.txt
(less: Space runter, b hoch, q beenden)

Alphabetisch sortiert:

cat
- Zeigt den Inhalt einer Datei im Terminal.
  Beispiel: cat schatz.txt
  Beispiel: cat ANLEITUNG.txt

cd
- Wechselt den Ordner.
  Beispiel: cd spiel
  Beispiel: cd ..

cp
- Kopiert Dateien oder Ordner.
  Beispiel: cp geheimcode.txt spiel/zimmer-jakob/schreibtisch/
  Beispiel: cp poster.txt spiel/zimmer-sophia/schreibtisch/

less
- Liest eine Datei zum Scrollen.
  Beispiel: less ANLEITUNG.txt
  Beispiel: less ~/bash-lexikon.txt

ls
- Listet Dateien und Ordner auf.
  Beispiel: ls
  Beispiel: ls -l

mkdir
- Erstellt Ordner.
  Beispiel: mkdir test
  Beispiel: mkdir -p a/b/c

mv
- Verschiebt oder benennt um.
  Beispiel: mv foto1.jpg spiel/ablage/bilder/
  Beispiel: mv alt.txt neu.txt

pwd
- Zeigt den aktuellen Ordner.
  Beispiel: pwd

rm
- Löscht Dateien (vorsichtig!).
  Beispiel: rm kaputt.tmp
  Beispiel: rm -r alter_ordner

touch
- Erstellt eine leere Datei (oder aktualisiert Zeitstempel).
  Beispiel: touch todo.txt
  Beispiel: touch neu.txt
EOF

  echo "✅ Lexikon aktualisiert: $LEX"
  exit 0
else
  echo "Noch nicht gewonnen – weiter so! 💪"
  exit 1
fi
