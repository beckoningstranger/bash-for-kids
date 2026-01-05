#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/spiel"
if [[ ! -d "$ROOT" ]]; then
  echo "❌ Spielordner nicht gefunden."
  echo "Tipp: Starte zuerst: bash spiel-vorbereiten.sh"
  exit 2
fi

fail=0

count_by_find() {
  local pattern="$1"
  local c=0
  while IFS= read -r -d '' _; do
    c=$((c+1))
  done < <(find "$ROOT" -type f -name "$pattern" -print0 2>/dev/null)
  echo "$c"
}

echo "🔎 LÖSEN / PRÜFEN (Lektion 4 – Wildcards)"
echo "Spielordner: $ROOT"
echo

# 1) Mathe tasks (20) in ablage/mathe
mathe_ok=1
for i in $(seq -w 1 20); do
  [[ -f "$ROOT/ablage/mathe/mathe_${i}.txt" ]] || mathe_ok=0
done
mathe_left=0
for i in $(seq -w 1 20); do
  [[ -f "$ROOT/eingang/mathe_${i}.txt" ]] && mathe_left=$((mathe_left+1))
done

if [[ $mathe_ok -eq 1 && $mathe_left -eq 0 ]]; then
  echo "✅ 1) Mathe-Aufgaben sind in ablage/mathe."
else
  echo "❌ 1) Mathe-Aufgaben noch nicht korrekt."
  [[ $mathe_ok -eq 0 ]] && echo "   - Mindestens eine mathe_XX.txt fehlt in ablage/mathe."
  [[ $mathe_left -ne 0 ]] && echo "   - Es liegen noch mathe_XX.txt im eingang (Tipp: mv eingang/mathe_[0-9][0-9].txt ablage/mathe/)."
  fail=1
fi

# 2) Mathe Lösungen (8) in ablage/loesungen
loes_ok=1
for i in $(seq -w 1 8); do
  [[ -f "$ROOT/ablage/loesungen/mathe_loesung_${i}.txt" ]] || loes_ok=0
done
loes_left=$(count_by_find "mathe_loesung_*.txt")

# loes_left counts also those in target; we need those remaining in eingang
loes_left_e=0
for i in $(seq -w 1 8); do
  [[ -f "$ROOT/eingang/mathe_loesung_${i}.txt" ]] && loes_left_e=$((loes_left_e+1))
done

if [[ $loes_ok -eq 1 && $loes_left_e -eq 0 ]]; then
  echo "✅ 2) Mathe-Lösungen sind in ablage/loesungen."
else
  echo "❌ 2) Mathe-Lösungen noch nicht korrekt."
  [[ $loes_ok -eq 0 ]] && echo "   - Mindestens eine mathe_loesung_XX.txt fehlt in ablage/loesungen."
  [[ $loes_left_e -ne 0 ]] && echo "   - Es liegen noch mathe_loesung_*.txt im eingang (Tipp: mv eingang/mathe_loesung_*.txt ablage/loesungen/)."
  fail=1
fi

# 3) Deutsch (18)
de_ok=1
for i in $(seq -w 1 18); do
  [[ -f "$ROOT/ablage/deutsch/deutsch_${i}.txt" ]] || de_ok=0
done
de_left=0
for i in $(seq -w 1 18); do
  [[ -f "$ROOT/eingang/deutsch_${i}.txt" ]] && de_left=$((de_left+1))
done

if [[ $de_ok -eq 1 && $de_left -eq 0 ]]; then
  echo "✅ 3) Deutsch-Dateien sind in ablage/deutsch."
else
  echo "❌ 3) Deutsch-Dateien noch nicht korrekt."
  [[ $de_ok -eq 0 ]] && echo "   - Mindestens eine deutsch_XX.txt fehlt in ablage/deutsch."
  [[ $de_left -ne 0 ]] && echo "   - Es liegen noch deutsch_XX.txt im eingang (Tipp: mv eingang/deutsch_[0-9][0-9].txt ablage/deutsch/)."
  fail=1
fi

# 4) Sport (16)
sp_ok=1
for i in $(seq -w 1 16); do
  [[ -f "$ROOT/ablage/sport/sport_${i}.txt" ]] || sp_ok=0
done
sp_left=0
for i in $(seq -w 1 16); do
  [[ -f "$ROOT/eingang/sport_${i}.txt" ]] && sp_left=$((sp_left+1))
done

if [[ $sp_ok -eq 1 && $sp_left -eq 0 ]]; then
  echo "✅ 4) Sport-Dateien sind in ablage/sport."
else
  echo "❌ 4) Sport-Dateien noch nicht korrekt."
  [[ $sp_ok -eq 0 ]] && echo "   - Mindestens eine sport_XX.txt fehlt in ablage/sport."
  [[ $sp_left -ne 0 ]] && echo "   - Es liegen noch sport_XX.txt im eingang (Tipp: mv eingang/sport_[0-9][0-9].txt ablage/sport/)."
  fail=1
fi

# 5) Archiv (_alt_) total 16
arch_ok=1
for i in $(seq -w 1 10); do
  [[ -f "$ROOT/archiv/deutsch_alt_${i}.txt" ]] || arch_ok=0
done
for i in $(seq -w 1 6); do
  [[ -f "$ROOT/archiv/mathe_alt_${i}.txt" ]] || arch_ok=0
done
alt_left=0
for i in $(seq -w 1 10); do
  [[ -f "$ROOT/eingang/deutsch_alt_${i}.txt" ]] && alt_left=$((alt_left+1))
done
for i in $(seq -w 1 6); do
  [[ -f "$ROOT/eingang/mathe_alt_${i}.txt" ]] && alt_left=$((alt_left+1))
done

if [[ $arch_ok -eq 1 && $alt_left -eq 0 ]]; then
  echo "✅ 5) Alle *_alt_* Dateien sind im archiv."
else
  echo "❌ 5) Archiv noch nicht korrekt."
  [[ $arch_ok -eq 0 ]] && echo "   - Mindestens eine *_alt_*.txt fehlt im archiv."
  [[ $alt_left -ne 0 ]] && echo "   - Es liegen noch *_alt_* Dateien im eingang (Tipp: mv eingang/*_alt_*.txt archiv/)."
  fail=1
fi

# 6) Bilder (30)
img_ok=1
for i in $(seq -w 1 30); do
  [[ -f "$ROOT/bilder/IMG_${i}.jpg" ]] || img_ok=0
done
img_left=0
for i in $(seq -w 1 30); do
  [[ -f "$ROOT/eingang/IMG_${i}.jpg" ]] && img_left=$((img_left+1))
done
if [[ $img_ok -eq 1 && $img_left -eq 0 ]]; then
  echo "✅ 6) Alle Bilder sind in bilder."
else
  echo "❌ 6) Bilder noch nicht korrekt."
  [[ $img_ok -eq 0 ]] && echo "   - Mindestens ein IMG_*.jpg fehlt in bilder."
  [[ $img_left -ne 0 ]] && echo "   - Es liegen noch Bilder im eingang (Tipp: mv eingang/IMG_*.jpg bilder/)."
  fail=1
fi

# 7) Notizen: note?.txt to kurz, note10 to lang
kurz_ok=1
for n in note1 note2 noteA; do
  [[ -f "$ROOT/ablage/notizen-kurz/${n}.txt" ]] || kurz_ok=0
done
kurz_left=0
for n in note1 note2 noteA; do
  [[ -f "$ROOT/eingang/${n}.txt" ]] && kurz_left=$((kurz_left+1))
done

lang_ok=$([[ -f "$ROOT/ablage/notizen-lang/note10.txt" ]] && echo 1 || echo 0)
lang_left=$([[ -f "$ROOT/eingang/note10.txt" ]] && echo 1 || echo 0)

if [[ $kurz_ok -eq 1 && $kurz_left -eq 0 && $lang_ok -eq 1 && $lang_left -eq 0 ]]; then
  echo "✅ 7) Notizen: note?.txt sind kurz, note10.txt ist lang."
else
  echo "❌ 7) Notizen noch nicht korrekt."
  [[ $kurz_ok -eq 0 ]] && echo "   - Mindestens eine note?.txt fehlt in ablage/notizen-kurz."
  [[ $kurz_left -ne 0 ]] && echo "   - Es liegt noch eine note?.txt im eingang (Tipp: mv eingang/note?.txt ablage/notizen-kurz/)."
  [[ $lang_ok -eq 0 ]] && echo "   - note10.txt fehlt in ablage/notizen-lang."
  [[ $lang_left -ne 0 ]] && echo "   - note10.txt liegt noch im eingang (Tipp: mv eingang/note10.txt ablage/notizen-lang/)."
  fail=1
fi

# 8) Müll löschen
kap_count=$(count_by_find "kaputt_*.tmp")
if [[ $kap_count -eq 0 ]]; then
  echo "✅ 8) Müll gelöscht: kaputt_*.tmp existiert nicht mehr."
else
  echo "❌ 8) Müll noch da: Es gibt noch $kap_count kaputt_*.tmp Dateien."
  echo "   Tipp: rm eingang/kaputt_*.tmp"
  fail=1
fi

echo
if [[ $fail -eq 0 ]]; then
  echo "🏆 GEWONNEN! Du hast das Sekretariat gerettet!"
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 4 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-4-geschafft.txt"

  # Lexikon neu schreiben (Stand: Lektion 4 – Wildcards)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 4)

Alphabetisch sortiert.

*  (Wildcard: beliebig viele Zeichen)
Beispiele:
ls mathe_*.txt
mv IMG_*.jpg bilder/

?  (Wildcard: genau ein Zeichen)
Beispiele:
ls note?.txt
ls note??.txt

cat  (Text anzeigen)
AUFBAU: cat DATEI

cd  (Ordner wechseln)
AUFBAU: cd ZIEL
Spezial: cd . | cd ..

cp  (kopieren)
AUFBAU: cp QUELLE... ZIEL

find  (finden)
AUFBAU: find WO -name DATEINAME

grep  (suchen)
AUFBAU: grep SUCHWORT DATEI1 DATEI2 ...

less  (lesen)
AUFBAU: less DATEI

ls  (auflisten)
AUFBAU: ls [OPTION] [ORDNER]

mkdir  (Ordner erstellen)
AUFBAU: mkdir ORDNER

mv  (verschieben/umbenennen)
AUFBAU: mv QUELLE... ZIEL
MERKSATZ: Letztes Argument ist das Ziel.

pwd  (aktueller Ordner)
AUFBAU: pwd

rm  (löschen) VORSICHT!
AUFBAU: rm DATEI...

touch  (leere Datei erstellen)
AUFBAU: touch DATEI
EOF
  echo "✅ Lexikon aktualisiert: $LEX"
  exit 0
else
  echo "Noch nicht gewonnen – du schaffst das! 💪"
  exit 1
fi
