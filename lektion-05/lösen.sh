#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/spiel"
LOGS="$ROOT/logs"
REPORT="$ROOT/bericht/diagnose.txt"

if [[ ! -d "$LOGS" ]]; then
  echo "❌ Spielordner nicht gefunden."
  echo "Tipp: bash spiel-vorbereiten.sh"
  exit 2
fi

# Expected counts (computed from logs)
exp_warn=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c "WARNUNG")
exp_err=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c "FEHLER")
exp_ok=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c "^OK ")

fail=0

echo "🔎 LÖSEN / PRÜFEN (Lektion 5 – Pipes)"
echo "Erwartet: WARNUNGEN=$exp_warn, FEHLER=$exp_err, OK=$exp_ok"
echo

if [[ -f "$REPORT" ]]; then
  echo "✅ 1) diagnose.txt existiert."
else
  echo "❌ 1) diagnose.txt fehlt."
  echo "   Tipp: Erstelle sie in spiel/bericht/diagnose.txt"
  fail=1
fi

line_warn=""
line_err=""
line_ok=""

if [[ -f "$REPORT" ]]; then
  # read first 3 lines
  IFS= read -r line_warn < "$REPORT" || true
  IFS= read -r line_err < <(sed -n '2p' "$REPORT") || true
  IFS= read -r line_ok  < <(sed -n '3p' "$REPORT") || true

  # ensure exactly 3 lines
  total_lines=$(wc -l < "$REPORT" | tr -d ' ')
  if [[ "$total_lines" -eq 3 ]]; then
    echo "✅ 2) diagnose.txt hat genau 3 Zeilen."
  else
    echo "❌ 2) diagnose.txt hat nicht genau 3 Zeilen (aktuell: $total_lines)."
    echo "   Tipp: Benutze > für die erste Zeile und >> für die nächsten."
    fail=1
  fi

  if [[ "$line_warn" == "WARNUNGEN: $exp_warn" ]]; then
    echo "✅ 3) WARNUNGEN-Zeile stimmt."
  else
    echo "❌ 3) WARNUNGEN-Zeile stimmt nicht."
    echo "   Erwartet: WARNUNGEN: $exp_warn"
    echo "   Tipp: cat logs/roboter-*.log | grep WARNUNG | wc -l"
    fail=1
  fi

  if [[ "$line_err" == "FEHLER: $exp_err" ]]; then
    echo "✅ 4) FEHLER-Zeile stimmt."
  else
    echo "❌ 4) FEHLER-Zeile stimmt nicht."
    echo "   Erwartet: FEHLER: $exp_err"
    echo "   Tipp: cat logs/roboter-*.log | grep FEHLER | wc -l"
    fail=1
  fi

  if [[ "$line_ok" == "OK: $exp_ok" ]]; then
    echo "✅ 5) OK-Zeile stimmt."
  else
    echo "❌ 5) OK-Zeile stimmt nicht."
    echo "   Erwartet: OK: $exp_ok"
    echo "   Tipp: cat logs/roboter-*.log | grep '^OK ' | wc -l"
    fail=1
  fi
fi

echo
if [[ $fail -eq 0 ]]; then
  echo "🏆 GEWONNEN! Du hast den Fabrik-Bericht erstellt!"
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 5 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-5-geschafft.txt"

  # Lexikon neu schreiben (Stand: Lektion 5 – Pipes)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 5)

Alphabetisch sortiert.

*  (Wildcard: beliebig viele Zeichen)
Beispiele: ls roboter-*.log | mv IMG_*.jpg bilder/

?  (Wildcard: genau ein Zeichen)
Beispiele: ls note?.txt | ls note??.txt

>  (umleiten = schreiben)
AUFBAU: BEFEHL > DATEI
- schreibt Ergebnis in DATEI (überschreibt)
Beispiele:
echo "Hallo" > text.txt
cat logs/roboter-01.log > kopie.txt

>> (anhängen)
AUFBAU: BEFEHL >> DATEI
- hängt Ergebnis unten an
Beispiele:
echo "Zeile 2" >> text.txt
echo "Zeile 3" >> text.txt

echo  (Text ausgeben)
AUFBAU: echo TEXT
Beispiele:
echo Hallo
echo "Zahl: 42"


|  (Pipe = Förderband)
AUFBAU: BEFEHL | BEFEHL
- Text von links wird rechts weiterverarbeitet
Beispiele:
cat logs/roboter-01.log | grep FEHLER
cat logs/roboter-*.log | grep WARNUNG | wc -l

cat  (Text anzeigen)
AUFBAU: cat DATEI

cd  (Ordner wechseln)
AUFBAU: cd ZIEL  (cd . | cd ..)

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
AUFBAU: mkdir ORDNER  (mkdir -p a/b/c)

mv  (verschieben/umbenennen)
AUFBAU: mv QUELLE... ZIEL

pwd  (aktueller Ordner)
AUFBAU: pwd

rm  (löschen) VORSICHT!
AUFBAU: rm DATEI...

touch  (leere Datei erstellen)
AUFBAU: touch DATEI

wc  (zählen)
AUFBAU: wc -l
- zählt Zeilen
Beispiele:
cat datei.txt | wc -l
grep FEHLER logs/roboter-01.log | wc -l
EOF
  echo "✅ Lexikon aktualisiert: $LEX"
  exit 0
else
  echo "Noch nicht gewonnen – weiter so! 💪"
  exit 1
fi
