#!/usr/bin/env bash
set -u
echo "LEVEL-ABSCHLUSS: Lektion 1 ✅"
echo
echo "Frage: Wo liegt der Schatz?"
echo
options=(
  "im Wald, in der Höhle"
  "im Wald, an der Lichtung"
  "im Wald, am Fluss"
  "auf dem Berg, am Gipfel"
  "auf dem Berg, in der Höhle"
  "im Dorf, im Haus"
  "im Dorf, im Turm"
  "am Meer, am Strand"
  "am Meer, auf der Insel, in der Höhle"
  "im Dorf, am Markt"
)
PS3="Deine Wahl (1-10): "
select choice in "${options[@]}"; do
  [[ -z "${choice:-}" ]] && echo "Bitte 1-10 wählen." && continue
  if [[ "$REPLY" == "9" ]]; then
    echo "🎉 Richtig!"
    mkdir -p "$HOME/bash-lernstand"
    echo "Lektion 1 geschafft! 🏆" > "$HOME/bash-lernstand/lektion-1-geschafft.txt"
    LEX="$HOME/bash-lexikon.txt"
    cat > "$LEX" <<'EOF'
BASH-LEXIKON 📘 (Stand: Lektion 1)

Alphabetisch sortiert:

cat  (Text anzeigen)
AUFBAU: cat DATEI
- DATEI: Datei, deren Inhalt angezeigt wird
Beispiele:
cat schatz.txt
cat ANLEITUNG.txt

cd  (change directory = Ordner wechseln)
AUFBAU: cd ZIEL
- ZIEL: Ordner, in den du wechseln willst
Spezial:
cd .   (bleibt hier)
cd ..  (ein Ordner nach oben)
Beispiele:
cd spiel
cd ..

less  (lesen)
AUFBAU: less DATEI
- DATEI: Datei, die gelesen wird (scrollen möglich)
Beispiele:
less ANLEITUNG.txt
less ~/bash-lexikon.txt

ls  (listen = auflisten)
AUFBAU: ls [OPTION] [ORDNER]
- OPTION: ändert die Anzeige (z.B. -l)
- ORDNER: optionaler Zielordner (sonst aktueller Ordner)
Beispiele:
ls
ls -l

pwd  (print working directory)
AUFBAU: pwd
- zeigt den aktuellen Ordner
Beispiel:
pwd
EOF
    echo "✅ Lexikon erstellt/aktualisiert: $LEX"
    exit 0
  else
    echo "❌ Noch nicht."
    exit 1
  fi
done
