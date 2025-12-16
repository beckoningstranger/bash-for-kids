#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT/zimmer-jakob"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/zimmer-sophia"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/ablage"/{texte,bilder,muell}
mkdir -p "$ROOT/hinweise"

echo "Mathe: 12 + 34 = ?" > "$ROOT/zimmer-jakob/boden/hausaufgaben.txt"
echo "Geschichte über einen Drachen (unfertig)" > "$ROOT/zimmer-jakob/schreibtisch/geschichte.txt"
echo "Einkaufsliste: Äpfel, Brot, Kakao" > "$ROOT/zimmer-sophia/boden/einkauf.txt"
echo "Notizen: Sophia mag Katzen" > "$ROOT/zimmer-sophia/schrank/notizen.txt"
echo "Alt und kaputt" > "$ROOT/zimmer-jakob/schrank/kaputt.tmp"

echo "BILD-DATEN (nicht echt)" > "$ROOT/zimmer-jakob/boden/foto1.jpg"
echo "BILD-DATEN (nicht echt)" > "$ROOT/zimmer-sophia/schreibtisch/foto2.jpg"
echo "BILD-DATEN (nicht echt)" > "$ROOT/zimmer-sophia/schrank/foto3.jpg"

echo "GEHEIMCODE: 9-4-7-1" > "$ROOT/zimmer-jakob/boden/geheimcode.txt"
echo "POSTER: Super Team!" > "$ROOT/zimmer-sophia/boden/poster.txt"

echo "Das ist nicht der Schatz, nur Papier." > "$ROOT/zimmer-jakob/boden/nicht_so_wichtig.txt"
echo "Bitte NICHT löschen: Das ist nur ein Hinweis." > "$ROOT/hinweise/hinweis.txt"

cat > "$ROOT/ANLEITUNG.txt" <<'EOF'
LEKTION 2 – AUFRÄUM-SPIEL (ZWEI ZIMMER) 🧹📦

Du liest diese Anleitung mit:
less ANLEITUNG.txt
(less: Space runter, b hoch, q beenden)

----------------------------------------
START (wie immer)

1) Spiel vorbereiten:
bash bereit-spiel-vor.sh

2) Spiel starten:
cd spiel

----------------------------------------
ZIELE 🎯

ZIEL 1: AUFRÄUMEN
- Alle .txt Dateien (außer geheimcode.txt, poster.txt, todo.txt) sollen in:
  ablage/texte
- Alle .jpg Dateien sollen in:
  ablage/bilder

ZIEL 2: DOPPELT AUF DIE SCHREIBTISCHE
Am Ende müssen BEIDE Dateien auf BEIDEN Schreibtischen liegen:
- geheimcode.txt
- poster.txt
Orte:
- zimmer-jakob/schreibtisch
- zimmer-sophia/schreibtisch

ZIEL 3: MÜLL WEG
- kaputt.tmp muss gelöscht werden.

ZIEL 4: ETWAS NEUES ERSTELLEN
- Erstelle auf Jakobs Schreibtisch: todo.txt

----------------------------------------
PRÜFEN

Im Ordner spiel:
bash pruefe-gewonnen.sh

Das Skript sagt dir, was noch fehlt.
EOF

echo "✅ Lektion 2 ist bereit."
echo "Starte mit: cd spiel"
echo "Lies dann: less ANLEITUNG.txt"
