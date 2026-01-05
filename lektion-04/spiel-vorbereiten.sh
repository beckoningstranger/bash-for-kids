#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT"/{eingang,ablage/{mathe,deutsch,sport,loesungen,notizen-kurz,notizen-lang},archiv,bilder,muell}

# Mathe: Aufgaben und Lösungen
for i in $(seq -w 1 20); do
  echo "MATHE AUFGABE $i: Rechne etwas aus." > "$ROOT/eingang/mathe_${i}.txt"
done
for i in $(seq -w 1 8); do
  echo "MATHE LÖSUNG $i: (geheim)" > "$ROOT/eingang/mathe_loesung_${i}.txt"
done

# Deutsch & Sport
for i in $(seq -w 1 18); do
  echo "DEUTSCH TEXT $i: Lies und verstehe." > "$ROOT/eingang/deutsch_${i}.txt"
done
for i in $(seq -w 1 16); do
  echo "SPORT NOTIZ $i: Bewegung ist gut." > "$ROOT/eingang/sport_${i}.txt"
done

# Alt-Dateien (müssen ins Archiv)
for i in $(seq -w 1 10); do
  echo "ALT: Das ist ein alter Zettel." > "$ROOT/eingang/deutsch_alt_${i}.txt"
done
for i in $(seq -w 1 6); do
  echo "ALT: Mathe war gestern." > "$ROOT/eingang/mathe_alt_${i}.txt"
done

# Bilder
for i in $(seq -w 1 30); do
  echo "JPEG-DATEN (nicht echt) $i" > "$ROOT/eingang/IMG_${i}.jpg"
done

# Müll (muss gelöscht werden)
for i in $(seq -w 1 12); do
  echo "KAPUTT $i" > "$ROOT/eingang/kaputt_${i}.tmp"
done

# Notizen für ? (kurz) und note10 (lang)
echo "NOTIZ eins" > "$ROOT/eingang/note1.txt"
echo "NOTIZ zwei" > "$ROOT/eingang/note2.txt"
echo "NOTIZ A" > "$ROOT/eingang/noteA.txt"
echo "NOTIZ zehn" > "$ROOT/eingang/note10.txt"

echo "✅ Lektion 4 (Wildcards) ist bereit."
echo "Tipp: cd spiel && ls eingang"
