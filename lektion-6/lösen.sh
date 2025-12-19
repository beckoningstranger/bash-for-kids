#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/spiel"
LOGS="$ROOT/logs"
REPORT="$ROOT/bericht/diagnose.txt"
BUILDER="$SCRIPT_DIR/bericht-erstellen.sh"

echo "🔎 LÖSEN / PRÜFEN (Lektion 6 – Substitution $(...))"
echo "Spielordner: $ROOT"
echo

fail=0

if [[ ! -d "$LOGS" ]]; then
  echo "❌ logs/ nicht gefunden."
  echo "   Tipp: bash spiel-vorbereiten.sh"
  exit 2
fi

if [[ ! -f "$BUILDER" ]]; then
  echo "❌ bericht-erstellen.sh fehlt."
  echo "   Tipp: Erstelle die Datei im Ordner lektion-6."
  exit 2
fi

if grep -q '\$\s*(' "$BUILDER"; then
  echo "✅ 1) Substitution $(...) in bericht-erstellen.sh gefunden."
else
  echo "❌ 1) In bericht-erstellen.sh wurde keine Substitution $(...) gefunden."
  echo "   Tipp: echo \"TEXT $(BEFEHL)\""
  fail=1
fi

# Erwartete Zahlen aus den Logs berechnen (das darf das Prüfsystem natürlich)
exp_warn=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c "WARNUNG" || true)
exp_err=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c "FEHLER" || true)
exp_ok=$(cat "$LOGS"/roboter-*.log 2>/dev/null | grep -c '^OK ' || true)

if [[ -f "$REPORT" ]]; then
  echo "✅ 2) diagnose.txt existiert."
else
  echo "❌ 2) diagnose.txt fehlt."
  echo "   Tipp: Führe dein Skript aus: bash bericht-erstellen.sh"
  fail=1
fi

if [[ -f "$REPORT" ]]; then
  # Genau 3 Zeilen?
  total_lines=$(wc -l < "$REPORT" | tr -d ' ')
  if [[ "$total_lines" -eq 3 ]]; then
    echo "✅ 3) diagnose.txt hat genau 3 Zeilen."
  else
    echo "❌ 3) diagnose.txt hat nicht genau 3 Zeilen (aktuell: $total_lines)."
    echo "   Tipp: Erste Zeile mit >, die nächsten mit >>."
    fail=1
  fi

  # Inhalt exakt prüfen (Zeile 1-3)
  line1="$(sed -n '1p' "$REPORT")"
  line2="$(sed -n '2p' "$REPORT")"
  line3="$(sed -n '3p' "$REPORT")"

  if [[ "$line1" == "WARNUNGEN: $exp_warn" ]]; then
    echo "✅ 4) WARNUNGEN-Zeile stimmt."
  else
    echo "❌ 4) WARNUNGEN-Zeile stimmt nicht."
    echo "   Erwartet: WARNUNGEN: $exp_warn"
    echo "   Tipp: cat spiel/logs/roboter-*.log | grep WARNUNG | wc -l"
    fail=1
  fi

  if [[ "$line2" == "FEHLER: $exp_err" ]]; then
    echo "✅ 5) FEHLER-Zeile stimmt."
  else
    echo "❌ 5) FEHLER-Zeile stimmt nicht."
    echo "   Erwartet: FEHLER: $exp_err"
    echo "   Tipp: cat spiel/logs/roboter-*.log | grep FEHLER | wc -l"
    fail=1
  fi

  if [[ "$line3" == "OK: $exp_ok" ]]; then
    echo "✅ 6) OK-Zeile stimmt."
  else
    echo "❌ 6) OK-Zeile stimmt nicht."
    echo "   Erwartet: OK: $exp_ok"
    echo "   Tipp: cat spiel/logs/roboter-*.log | grep '^OK ' | wc -l"
    fail=1
  fi
fi

echo
if [[ $fail -eq 0 ]]; then
  echo "🏆 GEWONNEN! Die Chef‑Maschine baut den Bericht automatisch."
  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 6 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-6-geschafft.txt"

  # Lexikon neu schreiben (Stand: Lektion 6 – Substitution)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 6)

Alphabetisch sortiert.

$(...)  (Substitution)
Bedeutet: Führe den inneren Befehl aus und setze sein Ergebnis als Text ein.
Beispiele:
echo "Zeilen: $(wc -l datei.txt)"
echo "Warnungen: $(cat logs/*.log | grep WARNUNG | wc -l)"

echo  (Text ausgeben)
AUFBAU: echo TEXT
Beispiele:
echo Hallo
echo "Zahl: 42"

|  (Pipe = verbinden)
AUFBAU: BEFEHL | BEFEHL
Beispiel:
cat logs/*.log | grep FEHLER | wc -l

>  (umleiten = schreiben)
AUFBAU: BEFEHL > DATEI

>> (anhängen)
AUFBAU: BEFEHL >> DATEI

*  (Wildcard: beliebig viele Zeichen)
Beispiel: mv IMG_*.jpg bilder/

?  (Wildcard: genau ein Zeichen)
Beispiel: mv note?.txt notizen/

cat
cd
cp
find
grep
less
ls
mkdir
mv
pwd
rm
touch
wc
EOF
  echo "✅ Lexikon aktualisiert: $LEX"
  exit 0
else
  echo "Noch nicht gewonnen – du schaffst das! 💪"
  exit 1
fi
