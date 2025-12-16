#!/usr/bin/env bash
set -u

OK=1

need_file () {
  local path="$1"
  local msg="$2"
  if [[ ! -f "$path" ]]; then
    echo "❌ FEHLT: $msg"
    echo "   (erwartet: $path)"
    OK=0
  fi
}

must_not_exist () {
  local path="$1"
  local msg="$2"
  if [[ -e "$path" ]]; then
    echo "❌ NOCH DA: $msg"
    echo "   (soll weg sein: $path)"
    OK=0
  fi
}

echo "🔎 Prüfe Gewinn-Zustand (Lektion 2) ..."
echo

jpg_elsewhere=0
while IFS= read -r -d '' f; do
  if [[ "$f" != "./ablage/bilder/"* ]]; then
    jpg_elsewhere=$((jpg_elsewhere+1))
  fi
done < <(find . -type f -name "*.jpg" -print0 2>/dev/null)

if [[ $jpg_elsewhere -ne 0 ]]; then
  echo "❌ Es liegen noch .jpg Dateien NICHT in ablage/bilder."
  echo "   Tipp: find . -name "*.jpg""
  OK=0
else
  echo "✅ Alle .jpg sind in ablage/bilder."
fi

txt_bad=0
while IFS= read -r -d '' f; do
  base="$(basename "$f")"
  if [[ "$base" == "geheimcode.txt" || "$base" == "poster.txt" || "$base" == "todo.txt" ]]; then
    continue
  fi
  if [[ "$f" != "./ablage/texte/"* ]]; then
    txt_bad=$((txt_bad+1))
  fi
done < <(find . -type f -name "*.txt" -print0 2>/dev/null)

if [[ $txt_bad -ne 0 ]]; then
  echo "❌ Es liegen noch .txt Dateien NICHT in ablage/texte (Ausnahmen: geheimcode/poster/todo)."
  echo "   Tipp: find . -name "*.txt""
  OK=0
else
  echo "✅ Alle normalen .txt sind in ablage/texte."
fi

echo
need_file "./zimmer-jakob/schreibtisch/geheimcode.txt" "geheimcode.txt auf Jakobs Schreibtisch"
need_file "./zimmer-sophia/schreibtisch/geheimcode.txt" "geheimcode.txt auf Sophias Schreibtisch"
need_file "./zimmer-jakob/schreibtisch/poster.txt" "poster.txt auf Jakobs Schreibtisch"
need_file "./zimmer-sophia/schreibtisch/poster.txt" "poster.txt auf Sophias Schreibtisch"

echo
must_not_exist "./zimmer-jakob/schrank/kaputt.tmp" "kaputt.tmp (muss gelöscht werden)"
must_not_exist "./ablage/muell/kaputt.tmp" "kaputt.tmp im Müll (bitte wirklich löschen)"
must_not_exist "./kaputt.tmp" "kaputt.tmp irgendwo"

echo
need_file "./zimmer-jakob/schreibtisch/todo.txt" "todo.txt auf Jakobs Schreibtisch (touch todo.txt)"

echo
echo "----------------------------------------"

if [[ $OK -eq 1 ]]; then
  echo "🏆 GEWONNEN! Super gemacht!"
  echo

  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 2 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-2-geschafft.txt"

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
  Beispiel: cp geheimcode.txt zimmer-jakob/schreibtisch/
  Beispiel: cp poster.txt zimmer-sophia/schreibtisch/

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
  Beispiel: mv foto1.jpg ablage/bilder/
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
  echo "Noch nicht ganz geschafft – aber du bist dran! 💪"
  exit 1
fi
