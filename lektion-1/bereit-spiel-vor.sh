#!/usr/bin/env bash
set -u

ROOT="spiel"

# Altes Spiel weg (nur im aktuellen Ordner)
rm -rf "$ROOT"

# Größere Struktur (Level 1)
mkdir -p "$ROOT"/{wald/{hoehle,lichtung,fluss},berg/{pfad,gipfel,hoehle},dorf/{haus,markt,turm},meer/{strand,insel/{palmen,hoehle}}}

# Schatz
cat > "$ROOT/meer/insel/hoehle/schatz.txt" <<'EOF'
🏆 SCHATZ GEFUNDEN! 🏆

Wenn du das liest, hast du es geschafft!

Merksatz für Papa:
"Der Schatz war auf der Insel im Meer, in der Höhle unter den Palmen."

Großartige Arbeit! 🎉
EOF

# Anleitung (für less, ohne Codeblöcke)
cat > "$ROOT/ANLEITUNG.txt" <<'EOF'
LEKTION 1 – SCHATZSUCHE 🗺️💎

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
ZIEL 🎯

Finde die Datei:
schatz.txt

Wenn du sie gefunden hast, lies sie mit:
cat schatz.txt
oder
less schatz.txt

Wenn du Papa den Merksatz sagen kannst, ist das super!

----------------------------------------
ERLAUBTE BEFEHLE (heute)

pwd
ls
cd
cat
less

----------------------------------------
BEFEHLE KURZ ERKLÄRT

pwd
- Zeigt: Wo bin ich gerade?

ls
- Zeigt: Was ist hier? (Dateien/Ordner)

cd NAME
- Geht in einen Ordner hinein.
Beispiel: cd wald

cd ..
- Geht einen Ordner zurück (nach oben).

cat DATEI
- Zeigt den Inhalt einer Datei.
Beispiel: cat schatz.txt

less DATEI
- Liest eine Datei (man kann scrollen).
Beispiel: less schatz.txt
In less: Space runter, b hoch, q beenden

----------------------------------------
WENN DU DEN SCHATZ HAST

Wenn du schatz.txt gelesen hast, führe aus:
bash loesen.sh

Das ist dein "Level abschließen"-Befehl.
EOF

echo "✅ Lektion 1 ist bereit."
echo "Starte mit: cd spiel"
echo "Lies dann: less ANLEITUNG.txt"
