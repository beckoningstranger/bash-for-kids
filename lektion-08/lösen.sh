#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/spiel"
SRC="$ROOT/haensel-und-gretel.txt"
OUT="$ROOT/neue-geschichte.txt"
WIZ="$SCRIPT_DIR/zauber.sh"

fail=0

echo "🔎 LÖSEN / PRÜFEN (Lektion 8 – sed)"
echo

if [[ ! -f "$WIZ" ]]; then
  echo "❌ zauber.sh fehlt."
  exit 2
fi

if grep -q "\bsed\b" "$WIZ"; then
  echo "✅ 1) In zauber.sh steht sed."
else
  echo "❌ 1) In zauber.sh steht noch kein sed."
  echo "   Tipp: Benutze sed im Skript, nicht von Hand."
  fail=1
fi

# Run the wizard script (so the child learns to automate)
echo "▶️  Ich führe dein zauber.sh aus..."
bash "$WIZ" >/dev/null 2>&1 || true

if [[ -f "$OUT" ]]; then
  echo "✅ 2) neue-geschichte.txt existiert."
else
  echo "❌ 2) neue-geschichte.txt fehlt."
  echo "   Tipp: Dein zauber.sh muss eine Datei schreiben: > spiel/neue-geschichte.txt"
  fail=1
fi

check_contains() {
  local needle="$1"
  local label="$2"
  if grep -q "$needle" "$OUT"; then
    echo "✅ $label"
  else
    echo "❌ $label"
    fail=1
  fi
}

check_absent() {
  local needle="$1"
  local label="$2"
  if grep -q "$needle" "$OUT"; then
    echo "❌ $label"
    fail=1
  else
    echo "✅ $label"
  fi
}

if [[ -f "$OUT" ]]; then
  check_contains "Jakob" "3) Hänsel wurde zu Jakob."
  check_contains "Sophia" "4) Gretel wurde zu Sophia."
  check_contains "Stadtpark" "5) Walde wurde zu Stadtpark."
  check_contains "Pizza" "6) Brot wurde zu Pizza."

  check_absent "Hänsel" "7) 'Hänsel' kommt nicht mehr vor."
  check_absent "Gretel" "8) 'Gretel' kommt nicht mehr vor."
  check_absent "Walde" "9) 'Walde' kommt nicht mehr vor."
  check_absent "Brot" "10) 'Brot' kommt nicht mehr vor."
fi

echo
if [[ $fail -eq 0 ]]; then
  echo "🏆 GEWONNEN! Du hast die Geschichte verzaubert."

  mkdir -p "$HOME/bash-lernstand"
  echo "Lektion 8 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-8-geschafft.txt"

  # Lexikon neu schreiben (Stand: Lektion 8)
  LEX="$HOME/bash-lexikon.txt"
  cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 8)

Alphabetisch sortiert (kurz).

$(...)  Substitution: Ergebnis eines Befehls als Text einsetzen
Beispiel: echo "Zeilen: $(wc -l datei.txt)"

*  Wildcard: beliebig viele Zeichen
Beispiel: ls logs/roboter-*.log

?  Wildcard: genau ein Zeichen
Beispiel: ls note?.txt

>  Umleiten (überschreibt Datei)
Beispiel: echo Hallo > text.txt

>> Anhängen (hängt an Datei an)
Beispiel: echo Zeile >> text.txt

|  Pipe (Förderband)
Beispiel: cat datei.txt | grep Wort | wc -l

cat  Datei anzeigen
cd   Ordner wechseln (. = hier, .. = darüber)
clear  Bildschirm leeren (nur Anzeige)
cp   kopieren
echo Text ausgeben
find Dateien finden
grep Text in Dateien suchen
history zeigt alte Befehle
less Datei lesen
ls   auflisten
man  Handbuch (oft Englisch, sehr genau)
mkdir Ordner erstellen
mv   verschieben/umbenennen
pwd  aktueller Ordner
rm   löschen (VORSICHT!)
sed  Text automatisch verändern (s/ALT/NEU/g)
touch leere Datei erstellen
wc   zählen (z.B. wc -l für Zeilen)
EOF
  echo "✅ Lexikon aktualisiert: $LEX"
  exit 0
else
  echo "Noch nicht gewonnen – du schaffst das! 💪"
  exit 1
fi
