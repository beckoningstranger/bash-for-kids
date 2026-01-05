#!/usr/bin/env bash
set -u

# In dieser Lektion ist die Geschichte bereits im Ordner spiel/ vorhanden.
# Wir setzen nur die Ergebnisdatei zurück.

ROOT="spiel"
rm -f "$ROOT/neue-geschichte.txt"

echo "✅ Lektion 8 ist bereit."
echo "Tipp: less spiel/haensel-und-gretel.txt"
