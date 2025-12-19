#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -d "$SCRIPT_DIR/spiel" ]]; then
  ROOT="$SCRIPT_DIR/spiel"
elif [[ -d "./ablage" && -d "./zimmer-jakob" ]]; then
  ROOT="$(pwd)"
else
  echo "❌ Ich finde den Spielordner nicht."
  exit 2
fi

jpg_elsewhere=0
while IFS= read -r -d '' f; do
  [[ "$f" != "$ROOT/ablage/bilder/"* ]] && jpg_elsewhere=$((jpg_elsewhere+1))
done < <(find "$ROOT" -type f -name "*.jpg" -print0 2>/dev/null)
task1a=$([[ $jpg_elsewhere -eq 0 ]] && echo 1 || echo 0)

txt_bad=0
while IFS= read -r -d '' f; do
  base="$(basename "$f")"
  [[ "$base" == "geheimcode.txt" || "$base" == "poster.txt" || "$base" == "todo.txt" ]] && continue
  [[ "$f" != "$ROOT/ablage/texte/"* ]] && txt_bad=$((txt_bad+1))
done < <(find "$ROOT" -type f -name "*.txt" -print0 2>/dev/null)
task1b=$([[ $txt_bad -eq 0 ]] && echo 1 || echo 0)

gc_j=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/geheimcode.txt" ]] && echo 1 || echo 0)
gc_s=$([[ -f "$ROOT/zimmer-sophia/schreibtisch/geheimcode.txt" ]] && echo 1 || echo 0)
po_j=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/poster.txt" ]] && echo 1 || echo 0)
po_s=$([[ -f "$ROOT/zimmer-sophia/schreibtisch/poster.txt" ]] && echo 1 || echo 0)
task2=$([[ $gc_j -eq 1 && $gc_s -eq 1 && $po_j -eq 1 && $po_s -eq 1 ]] && echo 1 || echo 0)

task3=$([[ ! -e "$ROOT/zimmer-jakob/schrank/kaputt.tmp" && ! -e "$ROOT/ablage/muell/kaputt.tmp" && ! -e "$ROOT/kaputt.tmp" ]] && echo 1 || echo 0)
task4=$([[ -f "$ROOT/zimmer-jakob/schreibtisch/todo.txt" ]] && echo 1 || echo 0)

echo "🔎 LÖSEN / PRÜFEN (Lektion 2)"
echo
echo "Checkliste:"

if [[ $task1a -eq 1 && $task1b -eq 1 ]]; then
  echo "✅ 1) Aufräumen: Bilder UND Texte sind richtig einsortiert."
else
  echo "❌ 1) Aufräumen noch nicht fertig."
  [[ $task1a -eq 0 ]] && echo "   - Es gibt noch .jpg außerhalb von ablage/bilder."
  [[ $task1b -eq 0 ]] && echo "   - Es gibt noch .txt außerhalb von ablage/texte (Ausnahmen: geheimcode/poster/todo)."
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
  echo "   Tipp: rm spiel/zimmer-jakob/schrank/kaputt.tmp"
fi

if [[ $task4 -eq 1 ]]; then
  echo "✅ 4) Neu erstellt: todo.txt liegt auf Jakobs Schreibtisch."
else
  echo "❌ 4) Neu erstellt noch nicht fertig."
  echo "   Tipp: touch spiel/zimmer-jakob/schreibtisch/todo.txt"
fi

echo
if [[ $task1a -eq 1 && $task1b -eq 1 && $task2 -eq 1 && $task3 -eq 1 && $task4 -eq 1 ]]; then
  echo "🏆 GEWONNEN!"
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 2 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-2-geschafft.txt"
  # Lexikon aktualisieren (nach der Lektion neu schreiben)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 2)

Alphabetisch sortiert:

cat  (Text anzeigen)
AUFBAU: cat DATEI
Beispiele: cat schatz.txt | cat ANLEITUNG.txt

cd  (Ordner wechseln)
AUFBAU: cd ZIEL
Spezial: cd . | cd ..
Beispiele: cd spiel | cd ..

cp  (copy = kopieren)
AUFBAU: cp QUELLE... ZIEL
- QUELLE...: Datei(en), die kopiert werden
- ZIEL: Zielordner (oder Dateiname)
Beispiele:
cp geheimcode.txt spiel/zimmer-jakob/schreibtisch/
cp poster.txt spiel/zimmer-sophia/schreibtisch/

less  (lesen)
AUFBAU: less DATEI
Beispiele: less ANLEITUNG.txt | less ~/bash-lexikon.txt

ls  (auflisten)
AUFBAU: ls [OPTION] [ORDNER]
Beispiele: ls | ls -l

mkdir  (Ordner erstellen)
AUFBAU: mkdir ORDNER
Beispiele: mkdir test | mkdir -p a/b/c

mv  (move = verschieben/umbenennen)
AUFBAU: mv QUELLE... ZIEL
MERKSATZ: Das LETZTE Argument ist das Ziel.
Beispiele:
mv foto1.jpg spiel/ablage/bilder/
mv alt.txt neu.txt

pwd  (aktueller Ordner)
AUFBAU: pwd

rm  (löschen) VORSICHT!
AUFBAU: rm DATEI
Beispiele: rm kaputt.tmp | rm -r alter_ordner

touch  (leere Datei erstellen)
AUFBAU: touch DATEI
Beispiele: touch todo.txt | touch neu.txt
EOF
  echo "✅ Lexikon aktualisiert: $LEX"

  exit 0
else
  exit 1
fi
