#!/usr/bin/env bash
set -u

ROOT="spiel"
rm -rf "$ROOT"

mkdir -p "$ROOT/zimmer-jakob"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/zimmer-sophia"/{schreibtisch,boden,schrank}
mkdir -p "$ROOT/ablage"/{texte,bilder,muell}

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

echo "✅ Lektion 2 ist bereit."
echo "Starte jetzt mit: cd spiel"
echo "Dann lies: less ../ANLEITUNG.txt"
