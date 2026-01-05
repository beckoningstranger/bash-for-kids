#!/usr/bin/env bash
set -u

read -p "Gib den gefundenen Satz ein: " input

if [[ "$input" == "Von Hobbingen zum Einsamen Berg" ]]; then
  echo "🏆 Richtig! Rätsel gelöst."
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 3 geschafft!" > "$HOME/bash-lernstand/lektion-3-geschafft.txt"
  # Lexikon aktualisieren (nach der Lektion neu schreiben)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 3)

Alphabetisch sortiert:

cat
AUFBAU: cat DATEI

cd
AUFBAU: cd ZIEL
Spezial: cd . | cd ..

cp
AUFBAU: cp QUELLE... ZIEL

find  (finden)
AUFBAU: find WO -name DATEINAME
- WO: wo gesucht wird (meistens .)
- -name: sucht nach dem Dateinamen
- DATEINAME: exakter Name
Beispiele:
find . -name "hinweis-rot.txt"
find . -name "hinweis-blau.txt"

grep  (suchen)
AUFBAU: grep SUCHWORT DATEI1 DATEI2 ...
MERKSATZ:
- ERSTES Argument = Suchwort
- ALLES danach = DATEIEN, in denen gesucht wird
grep sucht NICHT in Ordnern, sondern nur in Dateien.
Beispiele:
grep CODE hinweis-rot.txt
grep CODE hinweis-rot.txt hinweis-blau.txt

less
AUFBAU: less DATEI

ls
AUFBAU: ls [OPTION] [ORDNER]

mkdir
AUFBAU: mkdir ORDNER

mv
AUFBAU: mv QUELLE... ZIEL

pwd
AUFBAU: pwd

rm
AUFBAU: rm DATEI

touch
AUFBAU: touch DATEI
EOF
  echo "✅ Lexikon aktualisiert: $LEX"

  exit 0
else
  echo "❌ Das ist noch nicht richtig."
  exit 1
fi
