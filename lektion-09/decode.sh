#!/usr/bin/env bash
# set:
# -e  -> Skript bricht ab, wenn ein Befehl fehlschlägt
# -u  -> Fehler bei nicht gesetzten Variablen
# -o pipefail -> Fehler, wenn ein Teil einer Pipe fehlschlägt
set -euo pipefail

# read:
# -r -> liest den Text „roh“ (Backslashes haben keine Sonderrolle)
# -p -> zeigt vorher einen Text an (Prompt)
read -r -p "Gib die kodierte Nachricht ein (GROSSBUCHSTABEN): "

echo "Dekodierte Nachricht:"

# TODO:
# Schreibe eine Zeile, die den Text aus $REPLY wieder dekodiert.
# Tipp: Du brauchst echo, eine Pipe | und tr.
